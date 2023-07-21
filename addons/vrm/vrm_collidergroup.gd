@tool
extends Resource

# Bone name references are only valid within the given Skeleton.
# If the node was not a skeleton, bone is "" and contains a path to the node.
@export var node_path: NodePath

# The bone within the skeleton with the collider, or "" if not a bone.
@export var bone: String

@export var offset: Vector3
@export var tail: Vector3 # if is_capsule
@export var radius: float

@export var is_capsule: bool = false

# (Array, Plane)
# Only use in editor
@export var gizmo_color: Color = Color.MAGENTA

func create_runtime(secondary_node: Node3D, skeleton: Skeleton3D) -> VrmRuntimeCollider:
	var node: Node3D = null
	var bone_idx: int = -1
	if node_path != NodePath():
		node = secondary_node.get_node(node_path)
	if node == null and bone != "":
		bone_idx = skeleton.find_bone(bone)
	if node == null and bone_idx == -1:
		push_warning("spring collider: Unable to locate bone " + str(bone) + " or node " + str(node_path))
		node = secondary_node
	if is_capsule:
		return CapsuleCollider.new(bone_idx, node, offset, tail, radius)
	else:
		return SphereCollider.new(bone_idx, node, offset, radius)


#func _ready(ready_parent: Node3D, ready_skel: Object):
#	self.parent = ready_parent
#	if ready_parent.get_class() == "Skeleton3D":
#		self.skel = ready_skel
#		bone_idx = ready_parent.find_bone(bone)
#	setup()


#func _process():
#	for collider in colliders:
#		collider.update(parent, skel)


class VrmRuntimeCollider:
	var bone_idx: int
	var node: Node3D
	var offset: Vector3
	var radius: float
	var position: Vector3

	func _init(bone_idx: int, node: Node3D, collider_offset: Vector3 = Vector3.ZERO, collider_radius: float = 0.1):
		bone_idx = bone_idx
		offset = collider_offset
		radius = collider_radius

	func update(skel_global_xform_inv: Transform3D, center_transform_inv: Transform3D, skel: Skeleton3D):
		if bone_idx == -1:
			position = center_transform_inv * (skel.get_bone_global_pose(bone_idx) * offset)
		else:
			position = center_transform_inv * skel_global_xform_inv * node.global_transform * offset

	func collision(bone_position: Vector3, bone_radius: float, bone_length: float, out: Vector3, position_offset: Vector3=Vector3.ZERO) -> Vector3:
		var this_position = self.position + position_offset
		var r = bone_radius + self.radius
		var diff: Vector3 = out - this_position
		if (diff.x * diff.x + diff.y * diff.y + diff.z * diff.z) <= r * r:
			# Hit, move to orientation of normal
			var normal: Vector3 = (out - this_position).normalized()
			var pos_from_collider = this_position + normal * (bone_radius + self.radius)
			# Limiting bone length
			out = bone_position + (pos_from_collider - bone_position).normalized() * bone_length
		return out

class SphereCollider extends VrmRuntimeCollider:
	func _init(bone_idx: int, node: Node3D, collider_offset: Vector3, collider_radius: float):
		super(bone_idx, node, collider_offset, collider_radius)

class CapsuleCollider extends VrmRuntimeCollider:
	var tail_offset: Vector3
	var tail_position: Vector3

	func _init(bone_idx: int, node: Node3D, collider_offset: Vector3, collider_tail: Vector3, collider_radius: float):
		super(bone_idx, node, collider_offset, collider_radius)
		tail_offset = collider_tail

	func update(skel_global_xform_inv: Transform3D, center_transform_inv: Transform3D, skel: Skeleton3D):
		if bone_idx == -1:
			position = center_transform_inv * (skel.get_bone_global_pose(bone_idx) * offset)
			tail_position = center_transform_inv * (skel.get_bone_global_pose(bone_idx) * tail_offset)
		else:
			position = center_transform_inv * skel_global_xform_inv * node.global_transform * offset
			tail_position = center_transform_inv * skel_global_xform_inv * node.global_transform * tail_offset

	func collision(bone_position: Vector3, bone_radius: float, bone_length: float, out: Vector3, position_offset: Vector3=Vector3.ZERO) -> Vector3:
		var P: Vector3 = tail_position - position;
		var Q: Vector3 = bone_position - position - position_offset;
		var dot = P.dot(Q)
		if dot <= 0:
			return super.collision(bone_position, bone_radius, bone_length, out, position_offset)

		var t: float = dot / P.length()
		if t >= 1.0:
			return super.collision(bone_position, bone_radius, bone_length, out, position_offset + P)

		return super.collision(bone_position, bone_radius, bone_length, out, position_offset + P * t)
