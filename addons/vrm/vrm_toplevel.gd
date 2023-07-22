@tool
class_name VRMTopLevel
extends Node3D

const vrm_meta_class = preload("./vrm_meta.gd")

@export var vrm_skeleton: NodePath
@export var vrm_animplayer: NodePath
@export var vrm_secondary: NodePath

@export var vrm_meta: Resource = (func():
	var ret: Resource = vrm_meta_class.new()
	ret.resource_name = "CLICK TO SEE METADATA"
	return ret
).call()

@export_category("Springbone Settings")
@export var update_secondary_fixed: bool = false

@export var default_springbone_center: Node3D
@export var override_springbone_center: bool = false

@export_category("Editor and Debugging")
@export var update_in_editor: bool = false
@export var gizmo_spring_bone: bool = false
@export var gizmo_spring_bone_color: Color = Color.LIGHT_YELLOW


#class VRMUtil:
#	static func from_to_rotation_safe(from: Vector3, to: Vector3) -> Quaternion:
#		var axis: Vector3 = from.cross(to)
#		if is_equal_approx(axis.x, 0.0) and is_equal_approx(axis.y, 0.0) and is_equal_approx(axis.z, 0.0):
#			return Quaternion.IDENTITY
#		var angle: float = from.angle_to(to)
#		if is_equal_approx(angle, 0.0):
#			angle = 0.0
#		return Quaternion(axis.normalized(), angle)

	#static func transform_point(transform: Transform3D, point: Vector3) -> Vector3:
	#	var sc = transform.basis.get_scale()
	#	return (transform.basis.get_rotation_quaternion() * Vector3(point.x * sc.x, point.y * sc.y, point.z * sc.z)) + transform.origin

	#static func inv_transform_point(transform: Transform3D, point: Vector3) -> Vector3:
	#	var diff = point - transform.origin
	#	var sc = transform.basis.get_scale()
	#	return transform.basis.get_rotation_quaternion().inverse() * Vector3(diff.x / sc.x, diff.y / sc.y, diff.z / sc.z)
