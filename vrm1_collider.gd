@tool
extends Resource

# Bone name references are only valid within the given Skeleton.
# If the node was not a skeleton, bone is "" and contains a path to the node.
@export var skeleton_or_node: NodePath

# The bone within the skeleton with the collider, or "" if not a bone.
@export var bone: String

@export var offset: Vector3
@export var tail: Vector3 # if is_capsule
@export var radius: float

@export var is_capsule: bool = false

# (Array, Plane)
# Only use in editor
@export var gizmo_color: Color = Color.MAGENTA

#func setup():
#	if parent != null:
#		colliders.clear()
#		for collider in sphere_colliders:
#			colliders.append(SphereCollider.new(bone_idx, collider.normal, collider.d))


#func _ready(ready_parent: Node3D, ready_skel: Object):
#	self.parent = ready_parent
#	if ready_parent.get_class() == "Skeleton3D":
#		self.skel = ready_skel
#		bone_idx = ready_parent.find_bone(bone)
#	setup()


#func _process():
#	for collider in colliders:
#		collider.update(parent, skel)


class SphereCollider:
	var idx: int
	var offset: Vector3
	var radius: float
	var position: Vector3

	func _init(bone_idx: int, collider_offset: Vector3 = Vector3.ZERO, collider_radius: float = 0.1):
		idx = bone_idx
		offset = collider_offset
		radius = collider_radius

	func update(parent: Node3D, skel: Object):
		if parent.get_class() == "Skeleton3D" && idx != -1:
			var skeleton: Skeleton3D = parent as Skeleton3D
			position = (VRMTopLevel.VRMUtil.transform_point(skeleton.get_global_transform() * skel.get_bone_global_pose(idx), offset))
		else:
			position = VRMTopLevel.VRMUtil.transform_point(parent.global_transform, offset)

	func get_radius() -> float:
		return radius

	func get_position() -> Vector3:
		return position

class CapsuleCollider:
	var idx: int
	var offset: Vector3
	var axis: Vector3
	var height: float
	var radius: float
	var position: Vector3

	func _init(bone_idx: int, collider_offset: Vector3 = Vector3.ZERO, collider_radius: float = 0.1):
		idx = bone_idx
		offset = collider_offset
		radius = collider_radius

	func update(parent: Node3D, skel: Object):
		if parent.get_class() == "Skeleton3D" && idx != -1:
			var skeleton: Skeleton3D = parent as Skeleton3D
			position = (VRMTopLevel.VRMUtil.transform_point(skeleton.get_global_transform() * skel.get_bone_global_pose(idx), offset))
		else:
			position = VRMTopLevel.VRMUtil.transform_point(parent.global_transform, offset)

	func get_radius() -> float:
		return radius

	func get_position() -> Vector3:
		return position
