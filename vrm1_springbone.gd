@tool
extends Resource

const VRMSpringBoneLogic = preload("./vrm_spring_bone_logic.gd")

# Annotation comment
@export var comment: String

# bone name of the root bone of the swaying object, within skeleton.
@export var joint_nodes: PackedStringArray

# The resilience of the swaying object (the power of returning to the initial pose).
@export var stiffness_force: PackedFloat64Array
# The strength of gravity.
@export var gravity_power: PackedFloat64Array
# The direction of gravity. Set (0, -1, 0) for simulating the gravity.
# Set (1, 0, 0) for simulating the wind.
@export var gravity_dir: PackedVector3Array
# The resistance (deceleration) of automatic animation.
@export var drag_force: PackedFloat64Array
# The radius of the sphere used for the collision detection with colliders.
@export var hit_radius: PackedFloat64Array

# Bone name references are only valid within a given Skeleton.
@export var skeleton: NodePath

# The reference point of a swaying object can be set at any location except the origin.
# When implementing UI moving with warp, the parent node to move with warp can be
# specified if you don't want to make the object swaying with warp movement.",
# Exactly one of the following must be set.
@export var center_bone: String = ""
@export var center_node: NodePath

# Reference to the vrm_collidergroup for collisions with swaying objects.
@export var collider_groups: Array

# Props
var verlets: Array = []
var colliders: Array = []
var center = null
var skel: Skeleton3D = null


func setup(force: bool = false) -> void:
	if not self.root_bones.is_empty() && skel != null:
		if force || verlets.is_empty():
			if not verlets.is_empty():
				for verlet in verlets:
					verlet.reset(skel)
			verlets.clear()
			for go in joint_nodes:
				'''
				if typeof(go) != TYPE_NIL and not go.is_empty():
					setup_recursive(skel.find_bone(go), center)
				'''
				continue # FIXME


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


func _ready(ready_skel: Object, colliders_ref: Array) -> void:
	if ready_skel != null:
		self.skel = ready_skel
	setup()
	colliders = colliders_ref.duplicate(false)


func _process(delta) -> void:
	if verlets.is_empty():
		if joint_nodes.is_empty():
			return
		setup()

	var stiffness = stiffness_force * delta
	var external = gravity_dir * (gravity_power * delta)

	for verlet in verlets:
		verlet.radius = hit_radius
		verlet.update(skel, center, stiffness, drag_force, external, colliders)
