tool
extends Spatial

export var spring_bones: Array
export var collider_groups: Array

# Props
var spring_bones_internal: Array = []
var collider_groups_internal: Array = []
var secondary_gizmo: SecondaryGizmo

# Called when the node enters the scene tree for the first time.
func _ready():
	secondary_gizmo = SecondaryGizmo.new(self)
	add_child(secondary_gizmo)
	if not Engine.editor_hint:
		for collider_group in collider_groups:
			var new_collider_group = collider_group.duplicate(true)
			new_collider_group._ready(get_node(new_collider_group.skeleton_or_node))
			collider_groups_internal.append(new_collider_group)
		for spring_bone in spring_bones:
			var new_spring_bone = spring_bone.duplicate(true)
			var tmp_colliders: Array = []
			for i in range(collider_groups.size()):
				if new_spring_bone.collider_groups.has(collider_groups[i]):
					tmp_colliders.append_array(collider_groups_internal[i].colliders)
			new_spring_bone._ready(get_node(new_spring_bone.skeleton), tmp_colliders)
			spring_bones_internal.append(new_spring_bone)
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent() != null && not get_parent().update_secondary_fixed:
		if not Engine.editor_hint:
			# force update skeleton
			for spring_bone in spring_bones_internal:
				get_node(spring_bone.skeleton).get_bone_global_pose_without_override(0, true)
			for collider_group in collider_groups_internal:
				collider_group._process(get_node(collider_group.skeleton_or_node))
			for spring_bone in spring_bones_internal:
				spring_bone._process(delta, get_node(spring_bone.skeleton))
			if secondary_gizmo != null:
				secondary_gizmo.draw_in_game()
		if Engine.editor_hint:
			if secondary_gizmo != null:
				secondary_gizmo.draw_in_editor()
	return

# All animations to the Node need to be done in the _physics_process.
func _physics_process(delta):
	if get_parent() != null && get_parent().update_secondary_fixed:
		if not Engine.editor_hint:
			# force update skeleton
			for spring_bone in spring_bones_internal:
				get_node(spring_bone.skeleton).get_bone_global_pose_without_override(0, true)
			for collider_group in collider_groups_internal:
				collider_group._process(get_node(collider_group.skeleton_or_node))
			for spring_bone in spring_bones_internal:
				spring_bone._process(delta, get_node(spring_bone.skeleton))
			if secondary_gizmo != null:
				secondary_gizmo.draw_in_game()
		if Engine.editor_hint:
			if secondary_gizmo != null:
				secondary_gizmo.draw_in_editor()
	return





class SecondaryGizmo:
	extends ImmediateGeometry
	
	var secondary_node
	var m: SpatialMaterial = SpatialMaterial.new()
	
	func _init(parent):
		secondary_node = parent
		set_material()
		return
	
	func set_material():
		m.flags_unshaded = true
		m.flags_use_point_size = true
		m.flags_no_depth_test = true
		m.vertex_color_use_as_albedo = true
	
	func draw_in_editor():
		clear()
		var selected: Array = EditorPlugin.new().get_editor_interface().get_selection().get_selected_nodes()
		if selected.has(secondary_node.get_parent()) || selected.has(secondary_node):
			draw_collider_groups()
	
	func draw_in_game():
		clear()
		if secondary_node.get_parent().gizmo_spring_bone:
			draw_spring_bones(secondary_node.get_parent().gizmo_spring_bone_color)
	
	func draw_spring_bones(color: Color):
		set_material_override(m)
		# Spring bones
		for spring_bone in secondary_node.spring_bones_internal:
			for v in spring_bone.verlets:
				var s_sk: Skeleton = secondary_node.get_node(spring_bone.skeleton)
				var s_tr: Transform = s_sk.get_bone_global_pose_without_override(v.bone_idx)
				draw_line(
					s_tr.origin,
					VRMTopLevel.VRMUtil.inv_transform_point(s_sk.global_transform, v.current_tail),
					color
				)
				draw_sphere(
					s_tr,
					VRMTopLevel.VRMUtil.inv_transform_point(s_sk.global_transform, v.current_tail),
					spring_bone.hit_radius,
					color
				)
		return
	
	func draw_collider_groups():
		set_material_override(m)						
		for collider_group in secondary_node.collider_groups:
			var c_sk: Skeleton = secondary_node.get_node(collider_group.skeleton_or_node)
			var c_tr: Transform = c_sk.get_bone_global_pose_without_override(c_sk.find_bone(collider_group.bone))
			for collider in collider_group.sphere_colliders:
				var c_ps: Vector3 = VRMTopLevel.VRMUtil.coordinate_u2g(collider.normal)
				draw_sphere(c_tr, VRMTopLevel.VRMUtil.transform_point(c_tr, c_ps), collider.d, collider_group.gizmo_color)
		return
	
	func draw_line(begin_pos: Vector3, end_pos: Vector3, color: Color):
		begin(Mesh.PRIMITIVE_LINES)
		set_color(color)
		add_vertex(begin_pos)
		add_vertex(end_pos)
		end()
		return
	
	func draw_sphere(tr: Transform, center: Vector3, radius: float, color: Color):
		var step: int = 16
		var sppi: float = 2 * PI / step
		begin(Mesh.PRIMITIVE_LINE_LOOP)
		set_color(color)
		for i in range(step):
			add_vertex(center + (tr.basis * Vector3.UP * radius).rotated(tr.basis * Vector3.RIGHT, sppi * i))
		end()
		begin(Mesh.PRIMITIVE_LINE_LOOP)
		set_color(color)
		for i in range(step):
			add_vertex(center + (tr.basis * Vector3.RIGHT * radius).rotated(tr.basis * Vector3.FORWARD, sppi * i))
		end()
		begin(Mesh.PRIMITIVE_LINE_LOOP)
		set_color(color)
		for i in range(step):
			add_vertex(center + (tr.basis * Vector3.FORWARD * radius).rotated(tr.basis * Vector3.UP, sppi * i))
		end()
		return
