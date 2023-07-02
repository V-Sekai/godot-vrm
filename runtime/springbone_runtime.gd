extends RefCounted

var skeleton: Skeleton3D
var spring_bones: Array = []
var collider_groups: Array = []

const COLLIDER_SPHERE: int = 0
const COLLIDER_CAPSULE: int = 1

func _process(p_delta: float):
	pass

var collider_positions: PackedVector3Array
var collider_tails: PackedVector3Array
var collider_objects: Array[Resource]

var joint_collider_indices: PackedInt32Array
var joint_collider_positions: PackedVector3Array
var joint_collider_tails: PackedVector3Array

var joint_length_parentidx_boneidx: PackedVector3Array
var joint_current_tail: PackedVector3Array
var joint_prev_tail: PackedVector3Array
var joint_local_rotation: PackedColorArray
var joint_bone_axis: PackedVector3Array

var spring_bone_objects: Array[Resource]
var spring_joint_span: PackedInt32Array
var spring_collider_span: PackedInt32Array

var prev_skel_transform: Transform3D
var cur_skel_transform: Transform3D

# All values are skeleton-relative.
# Note that motion of the Skeleton3D node must be accounted for in any values kept from last frame.
func adapt_skeleton_movement():
	prev_skel_transform = cur_skel_transform
	cur_skel_transform = skeleton.global_transform
	if prev_skel_transform.is_equal_approx(cur_skel_transform):
		return
	var adjustment: Transform3D = cur_skel_transform * prev_skel_transform.affine_inverse()
	for elem in joint_prev_tail:
		elem = adjustment * elem

func update_collider_transforms():
	for i in range(len(collider_objects)):
		collider_objects[i]

class JointLogicState:
	var parent: int
	var bone: int
	var length: float
	var currentTail: Vector3
	var prevTail: Vector3
	var localRotation: Quaternion
	var boneAxis: Vector3

class ColliderState:
	var collider: Resource
	var cached_position: Vector3
	var cached_tail: Vector3

func init_state(skeleton: Skeleton3D, spring_bones: Array, collider_groups: Array):
	self.skeleton = skeleton
	self.spring_bones = spring_bones
	self.collider_groups = collider_groups


