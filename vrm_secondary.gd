@tool
class_name VRMSecondary
extends Node3D

const spring_bone_class = preload("./vrm_spring_bone.gd")
const collider_class = preload("./vrm_collider.gd")
const collider_group_class = preload("./vrm_collider_group.gd")

@export var spring_bones: Array[spring_bone_class]
@export var collider_groups: Array[collider_group_class]
@export_node_path("Skeleton3D") var skeleton: NodePath

var default_springbone_center: Node3D
var override_springbone_center: bool = false
var disable_colliders: bool = false
var springbone_gravity_multiplier: float = 1.0
var springbone_gravity_rotation: Quaternion = Quaternion.IDENTITY
var springbone_add_force: Vector3 = Vector3.ZERO

var update_secondary_fixed: bool = false
var update_in_editor: bool = false

var skel: Skeleton3D

# Props

var spring_bones_internal: Array[spring_bone_class]
var springs_centers: PackedInt32Array

var colliders_internal: Array[collider_class.VrmRuntimeCollider]
var colliders_centers: PackedInt32Array
var center_bones: PackedInt32Array
var center_nodes: Array[Node3D]

# Updated every frame
var center_transforms: Array[Transform3D]
var center_transforms_inv: Array[Transform3D]

var secondary_gizmo: SecondaryGizmo
var is_child_of_vrm: bool = false

# Collider state
# TODO: explore packed data to make processing optimization such as c++ easier.
#var collider_skel_positions: PackedVector3Array
#var collider_skel_tails: PackedVector3Array # is_capsule if not equal to collider_skel_positions
#var collider_radius: PackedFloat32Array
#const springbone_runtime = preload("./runtime/springbone_runtime.gd")
#var spring_logic: Array[springbone_runtime]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	skel = get_node(skeleton)
	if skel == null:
		return  # Not supported.

	var gizmo_spring_bone: bool = false
	if get_parent().script != null and get_parent().script.resource_path.get_file() == "vrm_toplevel.gd":
		is_child_of_vrm = true
	if is_child_of_vrm:
		update_secondary_fixed = get_parent().get("update_secondary_fixed")
		gizmo_spring_bone = get_parent().get("gizmo_spring_bone")
		disable_colliders = get_parent().get("disable_colliders")

#	if secondary_gizmo != null:
#		secondary_gizmo.get_parent().remove_child(secondary_gizmo)
#		secondary_gizmo.queue_free()
#		secondary_gizmo = null
	if secondary_gizmo == null and (Engine.is_editor_hint() or gizmo_spring_bone):
		secondary_gizmo = SecondaryGizmo.new(self)
		skel.add_child(secondary_gizmo, true)
	colliders_internal.clear()
	spring_bones_internal.clear()
	var center_to_collider_to_internal: Dictionary = {}
	var center_to_index: Dictionary = {}
	for spring_bone in spring_bones:
		var center_key: Variant = spring_bone.center_bone
		if spring_bone.center_bone == "":
			center_key = spring_bone.center_node

		if not center_to_index.has(center_key):
			center_to_index[center_key] = len(center_bones)
			if spring_bone.center_bone != "":
				center_bones.push_back(skel.find_bone(spring_bone.center_bone))
			else:
				center_bones.push_back(-1)
			if spring_bone.center_node == NodePath():
				center_nodes.push_back(null)
			else:
				center_nodes.push_back(get_node(spring_bone.center_node))
			center_transforms.push_back(Transform3D.IDENTITY)
			center_transforms_inv.push_back(Transform3D.IDENTITY)
		var center_idx: int = center_to_index[center_key]

	update_centers(skel.global_transform)

	for spring_bone in spring_bones:
		var center_key: Variant = spring_bone.center_bone
		if spring_bone.center_bone == "":
			center_key = spring_bone.center_node
		var center_idx: int = center_to_index[center_key]

		var tmp_colliders: Array[collider_class.VrmRuntimeCollider] = []
		for collider_group in spring_bone.collider_groups:
			for collider in collider_group.colliders:
				var collider_runtime: collider_class.VrmRuntimeCollider
				if center_key not in center_to_collider_to_internal:
					center_to_collider_to_internal[center_key] = {}
				if center_to_collider_to_internal[center_key].has(collider):
					collider_runtime = center_to_collider_to_internal[center_key][collider]
				else:
					collider_runtime = collider.create_runtime(self, skel)
					collider_runtime.gizmo_color = collider.gizmo_color
					colliders_internal.append(collider_runtime)
					colliders_centers.append(center_idx)
					center_to_collider_to_internal[center_key][collider] = collider_runtime
				tmp_colliders.append(collider_runtime)

		var new_spring_bone = spring_bone.duplicate(false)
		new_spring_bone.ready(skel, tmp_colliders, center_transforms_inv[center_idx])
		new_spring_bone.disable_colliders = disable_colliders
		spring_bones_internal.append(new_spring_bone)
		springs_centers.append(center_idx)


func check_for_editor_update() -> bool:
	if not Engine.is_editor_hint():
		return false
	if is_child_of_vrm:
		var parent: Node = get_parent()
		if parent.springbone_gravity_rotation != springbone_gravity_rotation or parent.springbone_gravity_multiplier != springbone_gravity_multiplier or parent.springbone_add_force != springbone_add_force:
			springbone_add_force = parent.springbone_add_force
			springbone_gravity_rotation = parent.springbone_gravity_rotation
			springbone_gravity_multiplier = parent.springbone_gravity_multiplier
			for sb in spring_bones_internal:
				sb.add_force = springbone_add_force
				sb.gravity_rotation = springbone_gravity_rotation
				sb.gravity_multiplier = springbone_gravity_multiplier
		if parent.disable_colliders != disable_colliders:
			disable_colliders = parent.disable_colliders
			for sb in spring_bones_internal:
				sb.disable_colliders = disable_colliders
		override_springbone_center = parent.override_springbone_center
		default_springbone_center = parent.default_springbone_center
		if parent.update_in_editor and not update_in_editor:
			update_in_editor = true
			_ready()
		if not parent.update_in_editor and update_in_editor:
			update_in_editor = false
			for spring_bone in spring_bones_internal:
				spring_bone.skel.clear_bones_global_pose_override()
	return update_in_editor


func update_centers(skel_transform: Transform3D):
	skel.get_bone_global_pose_no_override(0)
	var skel_transform_inv: Transform3D = skel_transform.affine_inverse()
	var center_xform: Transform3D
	var center_xform_inv: Transform3D
	if default_springbone_center != null:
		center_xform = default_springbone_center.global_transform
		center_xform_inv = center_xform.affine_inverse()
	for center_i in range(len(center_nodes)):
		var center_node: Node3D = center_nodes[center_i]
		if (center_bones[center_i] == -1 and center_node == null) or override_springbone_center:
			center_transforms[center_i] = skel_transform
			center_transforms_inv[center_i] = skel_transform_inv
			if default_springbone_center != null:
				center_transforms[center_i] = center_xform_inv * center_transforms[center_i]
				center_transforms_inv[center_i] = center_transforms_inv[center_i] * center_xform
		elif center_bones[center_i] == -1 and center_node != null:
			center_transforms[center_i] = center_node.global_transform.affine_inverse() * skel_transform
			center_transforms_inv[center_i] = skel_transform_inv * center_node.global_transform
		else:
			center_transforms[center_i] = skel.get_bone_global_pose(center_bones[center_i])
			center_transforms_inv[center_i] = center_transforms[center_i].affine_inverse()


func tick_spring_bones(delta: float) -> void:
	# force update skeleton

	if skel == null:
		return
	var skel_transform: Transform3D = skel.global_transform

	update_centers(skel_transform)

	for collider_i in range(len(colliders_internal)):
		colliders_internal[collider_i].update(skel_transform, center_transforms[colliders_centers[collider_i]], skel)
	for spring_i in range(len(spring_bones_internal)):
		spring_bones_internal[spring_i].update(delta, center_transforms[springs_centers[spring_i]], center_transforms_inv[springs_centers[spring_i]])

	if secondary_gizmo != null:
		if Engine.is_editor_hint():
			secondary_gizmo.draw_in_editor(true)
		else:
			secondary_gizmo.draw_in_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not update_secondary_fixed:
		if not Engine.is_editor_hint() or check_for_editor_update():
			tick_spring_bones(delta)
		elif Engine.is_editor_hint():
			if secondary_gizmo != null:
				if skel != null:
					var skel_transform: Transform3D = skel.global_transform
					update_centers(skel_transform)
					for collider_i in range(len(colliders_internal)):
						colliders_internal[collider_i].update(skel_transform, center_transforms[colliders_centers[collider_i]], skel)
					secondary_gizmo.draw_in_editor()


func _physics_process(delta: float) -> void:
	if update_secondary_fixed:
		if not Engine.is_editor_hint() or check_for_editor_update():
			tick_spring_bones(delta)
		elif Engine.is_editor_hint():
			if secondary_gizmo != null:
				if skel != null:
					var skel_transform: Transform3D = skel.global_transform
					update_centers(skel_transform)
					for collider_i in range(len(colliders_internal)):
						colliders_internal[collider_i].update(skel_transform, center_transforms[colliders_centers[collider_i]], skel)
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
		if secondary_node.is_child_of_vrm && secondary_node.get_parent().gizmo_spring_bone:
			draw_spring_bones(secondary_node.get_parent().gizmo_spring_bone_color)
			draw_collider_groups()

	func draw_in_game() -> void:
		mesh.clear_surfaces()
		if secondary_node.is_child_of_vrm && secondary_node.get_parent().gizmo_spring_bone:
			draw_spring_bones(secondary_node.get_parent().gizmo_spring_bone_color)
			draw_collider_groups()

	func draw_spring_bones(color: Color) -> void:
		set_material_override(m)
		var i: int = 0
		var s_sk: Skeleton3D = secondary_node.skel
		var s_sk_transform_inv: Transform3D = Transform3D.IDENTITY
		# Spring bones
		mesh.surface_begin(Mesh.PRIMITIVE_LINES)
		for spring_bone in secondary_node.spring_bones_internal:
			var center_transform_inv: Transform3D = secondary_node.center_transforms_inv[secondary_node.springs_centers[i]]
			for v in spring_bone.verlets:
				var s_tr: Transform3D = Transform3D.IDENTITY
				if v.bone_idx != -1:
					s_tr = s_sk.get_bone_global_pose(v.bone_idx)
				draw_line(s_tr.origin, center_transform_inv * v.current_tail, color)
			for v in spring_bone.verlets:
				var s_tr: Transform3D = Transform3D.IDENTITY
				if v.bone_idx != -1:
					s_tr = s_sk.get_bone_global_pose(v.bone_idx)
				draw_sphere(center_transform_inv.basis * s_tr.basis, center_transform_inv * v.current_tail, v.radius, color)
			i += 1
		mesh.surface_end()

	func draw_collider_groups() -> void:
		set_material_override(m)
		var i: int = 0
		var skel_inv: Transform3D = secondary_node.skel.global_transform.affine_inverse()
		mesh.surface_begin(Mesh.PRIMITIVE_LINES)
		for collider in secondary_node.colliders_internal:
			var center_transform_inv: Transform3D = secondary_node.center_transforms_inv[secondary_node.colliders_centers[i]]
			#var c_tr = Transform3D.IDENTITY
			#for collider in collider_group.sphere_colliders:
			#var c_ps: Vector3 = center_transform * collider.position
			collider.draw_debug(mesh, center_transform_inv)
			#draw_sphere(c_tr.basis, c_tr * c_ps, collider.radius, collider.gizmo_color)
			i += 1
		mesh.surface_end()

	func draw_sphere(bas: Basis, center: Vector3, radius: float, color: Color) -> void:
		var step: int = 15
		var sppi: float = 2 * PI / step
		for i in range(1, step + 1):
			mesh.surface_set_color(color)
			mesh.surface_add_vertex(center + ((bas * Vector3.UP * radius).rotated(bas * Vector3.RIGHT, sppi * (i - 1 % step))))
			mesh.surface_set_color(color)
			mesh.surface_add_vertex(center + ((bas * Vector3.UP * radius).rotated(bas * Vector3.RIGHT, sppi * (i % step))))
		for i in range(1, step + 1):
			mesh.surface_set_color(color)
			mesh.surface_add_vertex(center + ((bas * Vector3.RIGHT * radius).rotated(bas * Vector3.FORWARD, sppi * ((i - 1) % step))))
			mesh.surface_set_color(color)
			mesh.surface_add_vertex(center + ((bas * Vector3.RIGHT * radius).rotated(bas * Vector3.FORWARD, sppi * (i % step))))
		for i in range(1, step + 1):
			mesh.surface_set_color(color)
			mesh.surface_add_vertex(center + ((bas * Vector3.FORWARD * radius).rotated(bas * Vector3.UP, sppi * ((i - 1) % step))))
			mesh.surface_set_color(color)
			mesh.surface_add_vertex(center + ((bas * Vector3.FORWARD * radius).rotated(bas * Vector3.UP, sppi * (i % step))))

	func draw_line(begin_pos: Vector3, end_pos: Vector3, color: Color) -> void:
		mesh.surface_set_color(color)
		mesh.surface_add_vertex(begin_pos)
		mesh.surface_set_color(color)
		mesh.surface_add_vertex(end_pos)
