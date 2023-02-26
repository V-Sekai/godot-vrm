@tool
extends Resource

# Annotation comment
@export var comment: String

# The resilience of the swaying object (the power of returning to the initial pose).
@export_range(0, 4) var stiffness_force: float = 1.0
# The strength of gravity.
@export_range(0, 2) var gravity_power: float = 0.0

# The direction of gravity. Set (0, -1, 0) for simulating the gravity.
# Set (1, 0, 0) for simulating the wind.
@export var gravity_dir: Vector3 = Vector3(0.0, -1.0, 0.0)

# The resistance (deceleration) of automatic animation.
@export_range(0, 1) var drag_force: float = 0.4

# Bone name references are only valid within a given Skeleton.
@export var skeleton: NodePath

# The reference point of a swaying object can be set at any location except the origin.
# When implementing UI moving with warp, the parent node to move with warp can be
# specified if you don't want to make the object swaying with warp movement.",
# Exactly one of the following must be set.
@export var center_bone: String = ""
@export var center_node: NodePath

# The radius of the sphere used for the collision detection with colliders.
@export_range(0.0, 0.5) var hit_radius: float = 0.02

# bone name of the root bone of the swaying object, within skeleton.
@export var root_bones: Array = [].duplicate()  # DO NOT INITIALIZE HERE

# Reference to the vrm_collidergroup for collisions with swaying objects.
@export var collider_groups: Array = [].duplicate()  # DO NOT INITIALIZE HERE

# Props
var verlets: Array = [].duplicate()
var colliders: Array = [].duplicate()
var center = null
var skel: Skeleton3D = null


func setup(force: bool = false) -> void:
	if not self.root_bones.is_empty() && skel != null:
		if force || verlets.is_empty():
			if not verlets.is_empty():
				for verlet in verlets:
					verlet.reset(skel)
			verlets.clear()
			for go in root_bones:
				if typeof(go) != TYPE_NIL and not go.is_empty():
					setup_recursive(skel.find_bone(go), center)


func setup_recursive(id: int, center_tr) -> void:
	if skel.get_bone_children(id).is_empty():
		var delta: Vector3 = skel.get_bone_rest(id).origin
		var child_position: Vector3 = delta.normalized() * 0.07
		verlets.append(VRMSpringBoneLogic.new(skel, id, center_tr, child_position, skel.get_bone_global_pose_no_override(id)))
	else:
		var first_child: int = skel.get_bone_children(id)[0]
		var local_position: Vector3 = skel.get_bone_rest(first_child).origin
		var sca: Vector3 = skel.get_bone_rest(first_child).basis.get_scale()
		var pos: Vector3 = Vector3(local_position.x * sca.x, local_position.y * sca.y, local_position.z * sca.z)
		verlets.append(VRMSpringBoneLogic.new(skel, id, center_tr, pos, skel.get_bone_global_pose_no_override(id)))
	for child in skel.get_bone_children(id):
		setup_recursive(child, center_tr)


# Called when the node enters the scene tree for the first time.
func _ready(ready_skel: Object, colliders_ref: Array) -> void:
	if ready_skel != null:
		self.skel = ready_skel
	setup()
	colliders = colliders_ref.duplicate(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if verlets.is_empty():
		if root_bones.is_empty():
			return
		setup()

	var stiffness = stiffness_force * delta
	var external = gravity_dir * (gravity_power * delta)

	for verlet in verlets:
		verlet.radius = hit_radius
		verlet.update(skel, center, stiffness, drag_force, external, colliders)


# Individual spring bone entries.
class VRMSpringBoneLogic:
	var force_update: bool = true
	var bone_idx: int = -1

	var radius: float = 0
	var length: float = 0

	var bone_axis: Vector3
	var current_tail: Vector3
	var prev_tail: Vector3

	var initial_transform: Transform3D

	static func global_pose_to_local_pose(p_skeleton: Skeleton3D, p_bone_idx: int,  p_global_pose: Transform3D) -> Transform3D:
		var bone_size : int = p_skeleton.get_bone_count()
		if p_bone_idx < 0 or p_bone_idx >= bone_size:
			return Transform3D()
		if p_skeleton.get_bone_parent(p_bone_idx) >= 0:
			var parent_bone_idx : int = p_skeleton.get_bone_parent(p_bone_idx)
			var conversion_transform : Transform3D = p_skeleton.get_bone_global_pose(parent_bone_idx).affine_inverse()
			return conversion_transform * p_global_pose
		else:
			return p_global_pose
			
	static func local_pose_to_global_pose(p_skeleton : Skeleton3D, p_bone_idx: int, p_local_pose: Transform3D) -> Transform3D:
		var bone_size : int = p_skeleton.get_bone_count()
		if p_bone_idx < 0 or p_bone_idx >= bone_size:
			return Transform3D()
		if p_skeleton.get_bone_parent(p_bone_idx) >= 0:
			var parent_bone_idx : int = p_skeleton.get_bone_parent(p_bone_idx)
			return p_skeleton.get_bone_global_pose(parent_bone_idx) * p_local_pose;
		else:
			return p_local_pose


	func get_transform(skel: Skeleton3D) -> Transform3D:
		return skel.get_global_transform() * skel.get_bone_global_pose_no_override(bone_idx)

	func get_rotation_relative_to_origin(skel: Skeleton3D) -> Quaternion:
		return get_transform(skel).basis.get_rotation_quaternion()

	func get_global_pose(skel: Skeleton3D) -> Transform3D:
		return skel.get_bone_global_pose_no_override(bone_idx)

	func get_local_pose_rotation(skel: Skeleton3D) -> Quaternion:
		return get_global_pose(skel).basis.get_rotation_quaternion()

	func reset(skel: Skeleton3D) -> void:
		skel.set_bone_global_pose_override(bone_idx, initial_transform, 1.0, true)

	func _init(skel: Skeleton3D, idx: int, center, local_child_position: Vector3, default_pose: Transform3D) -> void:
		initial_transform = default_pose
		bone_idx = idx
		var world_child_position: Vector3 = VRMTopLevel.VRMUtil.transform_point(get_transform(skel), local_child_position)
		if typeof(center) != TYPE_NIL:
			current_tail = VRMTopLevel.VRMUtil.inv_transform_point(center, world_child_position)
		else:
			current_tail = world_child_position
		prev_tail = current_tail
		bone_axis = local_child_position.normalized()
		length = local_child_position.length()

	func update(skel: Skeleton3D, center, stiffness_force: float, drag_force: float, external: Vector3, colliders: Array) -> void:
		var tmp_current_tail: Vector3
		var tmp_prev_tail: Vector3
		if typeof(center) != TYPE_NIL:
			tmp_current_tail = VRMTopLevel.VRMUtil.transform_point(center, current_tail)
			tmp_prev_tail = VRMTopLevel.VRMUtil.transform_point(center, prev_tail)
		else:
			tmp_current_tail = current_tail
			tmp_prev_tail = prev_tail

		# Integration of velocity verlet
		var next_tail: Vector3 = tmp_current_tail + (tmp_current_tail - tmp_prev_tail) * (1.0 - drag_force) + (get_rotation_relative_to_origin(skel) * (bone_axis)) * stiffness_force + external

		# Limiting bone length
		var origin: Vector3 = get_transform(skel).origin
		next_tail = origin + (next_tail - origin).normalized() * length

		# Collision movement
		next_tail = collision(skel, colliders, next_tail)

		# Recording current tails for next process
		if typeof(center) != TYPE_NIL:
			prev_tail = VRMTopLevel.VRMUtil.inv_transform_point(center, current_tail)
			current_tail = VRMTopLevel.VRMUtil.inv_transform_point(center, next_tail)
		else:
			prev_tail = current_tail
			current_tail = next_tail

		# Apply rotation
		var ft = VRMTopLevel.VRMUtil.from_to_rotation(get_rotation_relative_to_origin(skel) * (bone_axis), next_tail - get_transform(skel).origin)
		if typeof(ft) != TYPE_NIL:
			ft = skel.global_transform.basis.get_rotation_quaternion().inverse() * ft
			var qt: Quaternion = ft * get_rotation_relative_to_origin(skel)
			var global_pose_tr: Transform3D = get_global_pose(skel)
			global_pose_tr.basis = Basis(qt.normalized())
			skel.set_bone_global_pose_override(bone_idx, global_pose_tr, 1.0, true)

	func collision(skel: Skeleton3D, colliders: Array, _next_tail: Vector3) -> Vector3:
		var out: Vector3 = _next_tail
		for collider in colliders:
			var r = radius + collider.get_radius()
			var diff: Vector3 = out - collider.get_position()
			if (diff.x * diff.x + diff.y * diff.y + diff.z * diff.z) <= r * r:
				# Hit, move to orientation of normal
				var normal: Vector3 = (out - collider.get_position()).normalized()
				var pos_from_collider = collider.get_position() + normal * (radius + collider.get_radius())
				# Limiting bone length
				var origin: Vector3 = get_transform(skel).origin
				out = origin + (pos_from_collider - origin).normalized() * length
		return out
