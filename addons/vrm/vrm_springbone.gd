@tool
extends Resource

const VRMSpringBoneLogic = preload("./vrm_spring_bone_logic.gd")

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
@export var root_bones: Array = []  # DO NOT INITIALIZE HERE

# Reference to the vrm_collidergroup for collisions with swaying objects.
@export var collider_groups: Array = []  # DO NOT INITIALIZE HERE

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


func _ready(ready_skel: Object, colliders_ref: Array) -> void:
	if ready_skel != null:
		self.skel = ready_skel
	setup()
	colliders = colliders_ref.duplicate(false)


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
