extends RefCounted

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
		global_pose_tr.basis = Basis(qt)
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
