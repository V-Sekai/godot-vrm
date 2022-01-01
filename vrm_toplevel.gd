class_name VRMTopLevel
extends Node3D


@export var vrm_skeleton: NodePath
@export var vrm_animplayer: NodePath
@export var vrm_secondary: NodePath

@export var vrm_meta: Resource

@export var update_secondary_fixed: bool = false

@export var update_in_editor: bool = false
@export var gizmo_spring_bone: bool = false
@export var gizmo_spring_bone_color: Color = Color.LIGHT_YELLOW

class VRMUtil:
	static func from_to_rotation(from: Vector3, to: Vector3) -> Quaternion:
		var axis: Vector3 = from.cross(to)
		if is_equal_approx(axis.x, 0.0) and is_equal_approx(axis.y, 0.0) and is_equal_approx(axis.z, 0.0):
			return Quaternion.IDENTITY
		var angle: float = from.angle_to(to)
		if is_equal_approx(angle, 0.0):
			angle = 0.0
		return Quaternion(axis.normalized(), angle)
	
	static func transform_point(transform: Transform3D, point: Vector3) -> Vector3:
		var sc = transform.basis.get_scale()
		return transform.basis.get_rotation_quaternion() * Vector3(point.x * sc.x, point.y * sc.y, point.z * sc.z) + transform.origin
	
	static func inv_transform_point(transform: Transform3D, point: Vector3) -> Vector3:
		var diff = point - transform.origin
		var sc = transform.basis.get_scale()
		return transform.basis.get_rotation_quaternion().inverse() * Vector3(diff.x / sc.x, diff.y / sc.y, diff.z / sc.z)
	
	# UniVRM will match XY-axis between Unity and OpenGL, so Z-axis will be flipped.
	# The coordinate issue may be fixed in VRM 1.0 or later.
	# https://github.com/vrm-c/vrm-specification/issues/205
	static func coordinate_u2g(vec: Vector3) -> Vector3:
		return Vector3(vec.x, vec.y, -vec.z)
