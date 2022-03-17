@tool
extends Resource

# Bone name references are only valid within the given Skeleton.
# If the node was not a skeleton, bone is "" and contains a path to the node.
@export var skeleton_or_node: NodePath

# The bone within the skeleton with the collider, or "" if not a bone.
@export var bone: String

# Note that Plane is commonly used in Godot in place of a Vector4.
# The "normal" property of Plane holds a Vector3 of data.
# There is a comment saying it "must be normalized".
# However, this is not enforced and regularly violated in the core engine itself.

# Plane.normal = The local coordinate from the node of the collider group in *left-handed* Y-up coordinate.
# Plane.d = The radius of the collider.
# The coordinate issue may be fixed in VRM 1.0 or later.
# https://github.com/vrm-c/vrm-specification/issues/205
@export  var sphere_colliders: Array # DO NOT INITIALIZE HERE
 # (Array, Plane)
# Only use in editor
@export var gizmo_color: Color = Color.MAGENTA

# Props
var colliders: Array = []
var bone_idx: int = -1
var parent: Node3D = null

var skel: Object = null

func setup():
	if parent != null:
		colliders.clear()
		for collider in sphere_colliders:
			colliders.append(SphereCollider.new(bone_idx, collider.normal, collider.d))


func _ready(ready_parent: Node3D, ready_skel: Object):
	self.parent = ready_parent
	if ready_parent.get_class() == "Skeleton3D":
		self.skel = ready_skel
		bone_idx = ready_parent.find_bone(bone)
	setup()


func _process():
	for collider in colliders:
		collider.update(parent, skel)


class SphereCollider:
	var idx: int
	var offset: Vector3
	var radius: float
	var position: Vector3
	
	func _init(bone_idx: int, collider_offset: Vector3 = Vector3.ZERO, collider_radius: float = 0.1):
		idx = bone_idx
		offset = VRMTopLevel.VRMUtil.coordinate_u2g(collider_offset)
		radius = collider_radius
	
	func update(parent: Node3D, skel: Object):
		if parent.get_class() == "Skeleton3D" && idx != -1:
			var skeleton: Skeleton3D = parent as Skeleton3D
			position = VRMTopLevel.VRMUtil.transform_point((skeleton.global_pose_to_world_transform(skel.get_bone_global_pose_no_override(idx))), offset)
		else:
			position = VRMTopLevel.VRMUtil.transform_point(parent.global_transform, offset)

	func get_radius() -> float:
		return radius
	
	func get_position() -> Vector3:
		return position
