@tool
extends Node3D

@export var spring_bones: Array
@export var collider_groups: Array

var update_secondary_fixed: bool = false
var update_in_editor: bool = false

# Props
var spring_bones_internal: Array = []
var collider_groups_internal: Array = []
var secondary_gizmo: SecondaryGizmo

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var gizmo_spring_bone: bool = false
	if get_parent() is VRMTopLevel:
		update_secondary_fixed = get_parent().get("update_secondary_fixed")
		gizmo_spring_bone = get_parent().get("gizmo_spring_bone")

	if secondary_gizmo == null and (Engine.is_editor_hint() or gizmo_spring_bone):
		secondary_gizmo = SecondaryGizmo.new(self)
		add_child(secondary_gizmo, true)
	collider_groups_internal.clear()
	spring_bones_internal.clear()
	for collider_group in collider_groups:
		var new_collider_group = collider_group.duplicate(true)
		var parent: Node3D = get_node_or_null(new_collider_group.skeleton_or_node)
		if parent != null:
			new_collider_group._ready(parent, parent)
			collider_groups_internal.append(new_collider_group)
	for spring_bone in spring_bones:
		var new_spring_bone = spring_bone.duplicate(true)
		var tmp_colliders: Array = []
		for i in range(collider_groups.size()):
			if new_spring_bone.collider_groups.has(collider_groups[i]):
				tmp_colliders.append_array(collider_groups_internal[i].colliders)
		var skel: Skeleton3D = get_node_or_null(new_spring_bone.skeleton)
		if skel != null:
			new_spring_bone._ready(skel, tmp_colliders)
			spring_bones_internal.append(new_spring_bone)

func check_for_editor_update() -> bool:
	if not Engine.is_editor_hint():
		return false
	var parent: Node = get_parent()
	if parent is VRMTopLevel:
		if parent.update_in_editor and not update_in_editor:
			update_in_editor = true
			_ready()
		if not parent.update_in_editor and update_in_editor:
			update_in_editor = false
			for spring_bone in spring_bones_internal:
				spring_bone.skel.clear_bones_global_pose_override()
	return update_in_editor

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if not update_secondary_fixed:
		if not Engine.is_editor_hint() or check_for_editor_update():
			# force update skeleton
			for spring_bone in spring_bones_internal:
				if spring_bone.skel != null:
					spring_bone.skel.get_bone_global_pose_no_override(0)
			for collider_group in collider_groups_internal:
				collider_group._process()
			for spring_bone in spring_bones_internal:
				spring_bone._process(delta)
			if secondary_gizmo != null:
				if Engine.is_editor_hint():
					secondary_gizmo.draw_in_editor(true)
				else:
					secondary_gizmo.draw_in_game()
		elif Engine.is_editor_hint():
			if secondary_gizmo != null:
				secondary_gizmo.draw_in_editor()

func _physics_process(delta) -> void:
	if update_secondary_fixed:
		if not Engine.is_editor_hint() or check_for_editor_update():
			# force update skeleton
			for spring_bone in spring_bones_internal:
				if spring_bone.skel != null:
					spring_bone.skel.get_bone_global_pose_no_override(0)
			for collider_group in collider_groups_internal:
				collider_group._process()
			for spring_bone in spring_bones_internal:
				spring_bone._process(delta)
			if secondary_gizmo != null:
				if Engine.is_editor_hint():
					secondary_gizmo.draw_in_editor(true)
				else:
					secondary_gizmo.draw_in_game()
		elif Engine.is_editor_hint():
			if secondary_gizmo != null:
				secondary_gizmo.draw_in_editor()


class SecondaryGizmo:
	extends MeshInstance3D

	var secondary_node
	var m: StandardMaterial3D = StandardMaterial3D.new()

	func _init(parent) -> void:
		mesh = ImmediateMesh.new()
		secondary_node = parent
		m.no_depth_test = true
		m.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		m.vertex_color_use_as_albedo = true
		m.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA

	func draw_in_editor(do_draw_spring_bones: bool = false) -> void:
		mesh.clear_surfaces()
		if secondary_node.get_parent() is VRMTopLevel && secondary_node.get_parent().gizmo_spring_bone:
			draw_spring_bones(secondary_node.get_parent().gizmo_spring_bone_color)
			draw_collider_groups()

	func draw_in_game() -> void:
		mesh.clear_surfaces()
		if secondary_node.get_parent() is VRMTopLevel && secondary_node.get_parent().gizmo_spring_bone:
			draw_spring_bones(secondary_node.get_parent().gizmo_spring_bone_color)
			draw_collider_groups()

	func draw_spring_bones(color: Color) -> void:
		set_material_override(m)
		# Spring bones
		for spring_bone in secondary_node.spring_bones_internal:
			mesh.surface_begin(Mesh.PRIMITIVE_LINES)
			for v in spring_bone.verlets:
				var s_tr: Transform3D = Transform3D.IDENTITY
				var s_sk: Skeleton3D = spring_bone.skel
				if Engine.is_editor_hint():
					s_sk = secondary_node.get_node_or_null(spring_bone.skeleton)
					if v.bone_idx != -1:
						s_tr = s_sk.get_bone_global_pose(v.bone_idx)
				else:
					s_tr = spring_bone.skel.get_bone_global_pose_no_override(v.bone_idx)
				draw_line(
					s_tr.origin,
					VRMTopLevel.VRMUtil.inv_transform_point(s_sk.global_transform, v.current_tail),
					color
				)
			mesh.surface_end()
			for v in spring_bone.verlets:
				mesh.surface_begin(Mesh.PRIMITIVE_LINE_STRIP)
				var s_tr: Transform3D = Transform3D.IDENTITY
				var s_sk: Skeleton3D = spring_bone.skel
				if Engine.is_editor_hint():
					s_sk = secondary_node.get_node_or_null(spring_bone.skeleton)
					if v.bone_idx != -1:
						s_tr = s_sk.get_bone_global_pose(v.bone_idx)
				else:
					s_tr = spring_bone.skel.get_bone_global_pose_no_override(v.bone_idx)
				draw_sphere(
					s_tr.basis,
					VRMTopLevel.VRMUtil.inv_transform_point(s_sk.global_transform, v.current_tail),
					spring_bone.hit_radius,
					color
				)
				mesh.surface_end()

	func draw_collider_groups() -> void:
		set_material_override(m)
		for collider_group in (secondary_node.collider_groups if Engine.is_editor_hint() else secondary_node.collider_groups_internal):
			mesh.surface_begin(Mesh.PRIMITIVE_LINE_STRIP)
			var c_tr = Transform3D.IDENTITY
			if Engine.is_editor_hint():
				var c_sk: Node = secondary_node.get_node_or_null(collider_group.skeleton_or_node)
				if c_sk is Skeleton3D:
					if collider_group.bone_idx == -1:
						collider_group.bone_idx = c_sk.find_bone(collider_group.bone)
					c_tr = c_sk.get_bone_global_pose(collider_group.bone_idx)
			elif collider_group.parent is Skeleton3D:
				c_tr = collider_group.skel.get_bone_global_pose_no_override(collider_group.parent.find_bone(collider_group.bone))
			for collider in collider_group.sphere_colliders:
				var c_ps: Vector3 = Vector3(0,0,0) # VRMTopLevel.VRMUtil.coordinate_u2g(collider.normal)
				draw_sphere(c_tr.basis, VRMTopLevel.VRMUtil.transform_point(c_tr, c_ps), collider.d, collider_group.gizmo_color)
			mesh.surface_end()

	func draw_line(begin_pos: Vector3, end_pos: Vector3, color: Color) -> void:
		mesh.surface_set_color(color)
		mesh.surface_add_vertex(begin_pos)
		mesh.surface_set_color(color)
		mesh.surface_add_vertex(end_pos)

	func draw_sphere(bas: Basis, center: Vector3, radius: float, color: Color) -> void:
		var step: int = 15
		var sppi: float = 2 * PI / step
		for i in range(step + 1):
			mesh.surface_set_color(color)
			mesh.surface_add_vertex(center + (bas * Vector3.UP * radius).rotated(bas * Vector3.RIGHT, sppi * (i % step)))
		for i in range(step + 1):
			mesh.surface_set_color(color)
			mesh.surface_add_vertex(center + (bas * Vector3.RIGHT * radius).rotated(bas * Vector3.FORWARD, sppi * (i % step)))
		for i in range(step + 1):
			mesh.surface_set_color(color)
			mesh.surface_add_vertex(center + (bas * Vector3.FORWARD * radius).rotated(bas * Vector3.UP, sppi * (i % step)))

