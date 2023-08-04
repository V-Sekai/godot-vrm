extends RefCounted

const ROTATE_180_BASIS = Basis(Vector3(-1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, -1))
const ROTATE_180_TRANSFORM = Transform3D(ROTATE_180_BASIS, Vector3.ZERO)


static func adjust_mesh_zforward(mesh: ImporterMesh):
	# MESH and SKIN data divide, to compensate for object position multiplying.
	var surf_count: int = mesh.get_surface_count()
	var surf_data_by_mesh = [].duplicate()
	var blendshapes = []
	for bsidx in mesh.get_blend_shape_count():
		blendshapes.append(mesh.get_blend_shape_name(bsidx))
	for surf_idx in range(surf_count):
		var prim: int = mesh.get_surface_primitive_type(surf_idx)
		var fmt_compress_flags: int = mesh.get_surface_format(surf_idx)
		var arr: Array = mesh.get_surface_arrays(surf_idx)
		var name: String = mesh.get_surface_name(surf_idx)
		var bscount = mesh.get_blend_shape_count()
		var bsarr: Array[Array] = []
		for bsidx in range(bscount):
			bsarr.append(mesh.get_surface_blend_shape_arrays(surf_idx, bsidx))
		var lods: Dictionary = {}  # mesh.surface_get_lods(surf_idx) # get_lods(mesh, surf_idx)
		var mat: Material = mesh.get_surface_material(surf_idx)
		var vert_arr_len: int = len(arr[ArrayMesh.ARRAY_VERTEX])
		var vertarr: PackedVector3Array = arr[ArrayMesh.ARRAY_VERTEX]
		var invert_vector = Vector3(-1, 1, -1)
		for i in range(vert_arr_len):
			vertarr[i] = invert_vector * vertarr[i]
		if typeof(arr[ArrayMesh.ARRAY_NORMAL]) == TYPE_PACKED_VECTOR3_ARRAY:
			var normarr: PackedVector3Array = arr[ArrayMesh.ARRAY_NORMAL]
			for i in range(vert_arr_len):
				normarr[i] = invert_vector * normarr[i]
		if typeof(arr[ArrayMesh.ARRAY_TANGENT]) == TYPE_PACKED_FLOAT32_ARRAY:
			var tangarr: PackedFloat32Array = arr[ArrayMesh.ARRAY_TANGENT]
			for i in range(vert_arr_len):
				tangarr[i * 4] = -tangarr[i * 4]
				tangarr[i * 4 + 2] = -tangarr[i * 4 + 2]
		for bsidx in range(len(bsarr)):
			vertarr = bsarr[bsidx][ArrayMesh.ARRAY_VERTEX]
			for i in range(vert_arr_len):
				vertarr[i] = invert_vector * vertarr[i]
			if typeof(bsarr[bsidx][ArrayMesh.ARRAY_NORMAL]) == TYPE_PACKED_VECTOR3_ARRAY:
				var normarr: PackedVector3Array = bsarr[bsidx][ArrayMesh.ARRAY_NORMAL]
				for i in range(vert_arr_len):
					normarr[i] = invert_vector * normarr[i]
			if typeof(bsarr[bsidx][ArrayMesh.ARRAY_TANGENT]) == TYPE_PACKED_FLOAT32_ARRAY:
				var tangarr: PackedFloat32Array = bsarr[bsidx][ArrayMesh.ARRAY_TANGENT]
				for i in range(vert_arr_len):
					tangarr[i * 4] = -tangarr[i * 4]
					tangarr[i * 4 + 2] = -tangarr[i * 4 + 2]
			bsarr[bsidx].resize(ArrayMesh.ARRAY_MAX)

		surf_data_by_mesh.push_back({"prim": prim, "arr": arr, "bsarr": bsarr, "lods": lods, "fmt_compress_flags": fmt_compress_flags, "name": name, "mat": mat})
	mesh.clear()
	for blend_name in blendshapes:
		mesh.add_blend_shape(blend_name)
	for surf_idx in range(surf_count):
		var prim: int = surf_data_by_mesh[surf_idx].get("prim")
		var arr: Array = surf_data_by_mesh[surf_idx].get("arr")
		var bsarr: Array[Array] = surf_data_by_mesh[surf_idx].get("bsarr")
		var lods: Dictionary = surf_data_by_mesh[surf_idx].get("lods")
		var fmt_compress_flags: int = surf_data_by_mesh[surf_idx].get("fmt_compress_flags")
		var name: String = surf_data_by_mesh[surf_idx].get("name")
		var mat: Material = surf_data_by_mesh[surf_idx].get("mat")
		mesh.add_surface(prim, arr, bsarr, lods, mat, name, fmt_compress_flags)


static func rotate_scene_180_inner(p_node: Node3D, mesh_set: Dictionary, skin_set: Dictionary):
	if p_node is Skeleton3D:
		for bone_idx in range(p_node.get_bone_count()):
			var rest: Transform3D = ROTATE_180_TRANSFORM * p_node.get_bone_rest(bone_idx) * ROTATE_180_TRANSFORM
			p_node.set_bone_rest(bone_idx, rest)
			p_node.set_bone_pose_rotation(bone_idx, Quaternion(ROTATE_180_BASIS) * p_node.get_bone_pose_rotation(bone_idx) * Quaternion(ROTATE_180_BASIS))
			p_node.set_bone_pose_scale(bone_idx, Vector3.ONE)
			p_node.set_bone_pose_position(bone_idx, rest.origin)
	p_node.transform = ROTATE_180_TRANSFORM * p_node.transform * ROTATE_180_TRANSFORM
	if p_node is ImporterMeshInstance3D:
		mesh_set[p_node.mesh] = true
		if p_node.skin != null:
			skin_set[p_node.skin] = true
	for child in p_node.get_children():
		rotate_scene_180_inner(child, mesh_set, skin_set)


static func rotate_scene_180(p_scene: Node3D):
	var mesh_set: Dictionary = {}
	var skin_set: Dictionary = {}
	rotate_scene_180_inner(p_scene, mesh_set, skin_set)
	for mesh in mesh_set:
		adjust_mesh_zforward(mesh)
	for skin in skin_set:
		for b in range(skin.get_bind_count()):
			skin.set_bind_pose(b, ROTATE_180_TRANSFORM * skin.get_bind_pose(b) * ROTATE_180_TRANSFORM)


static func apply_node_transforms(p_root_node: Node3D, p_skeleton: Skeleton3D) -> Vector3:
	var global_transform: Transform3D = Transform3D.IDENTITY
	var pr: Node3D = p_skeleton
	while pr != null:
		global_transform = pr.transform * global_transform
		pr.transform = Transform3D.IDENTITY
		pr = pr.get_parent() as Node3D

	global_transform.origin = Vector3.ZERO

	# get_scale_local() not exposed to GDScript?
	var sign_det: float = sign(global_transform.basis.determinant())
	var rowx: Vector3 = Vector3(global_transform.basis.x.x, global_transform.basis.y.x, global_transform.basis.z.x)
	var rowy: Vector3 = Vector3(global_transform.basis.x.y, global_transform.basis.y.y, global_transform.basis.z.y)
	var rowz: Vector3 = Vector3(global_transform.basis.x.z, global_transform.basis.y.z, global_transform.basis.z.z)

	var global_transform_scale_local: Vector3 = sign_det * Vector3(rowx.length(), rowy.length(), rowz.length())

	for bone_idx in p_skeleton.get_parentless_bones():
		var new_rest: Transform3D = global_transform.orthonormalized() * p_skeleton.get_bone_rest(bone_idx)
		p_skeleton.set_bone_rest(bone_idx, new_rest)

	var q: PackedInt32Array = p_skeleton.get_parentless_bones()
	var q_off: int = 0
	while q_off < len(q):
		var src_idx: int = q[q_off]
		q_off += 1
		var src_children: PackedInt32Array = p_skeleton.get_bone_children(src_idx)
		q.append_array(src_children)
		var bone_rest: Transform3D = p_skeleton.get_bone_rest(src_idx)
		p_skeleton.set_bone_rest(src_idx, Transform3D(bone_rest.basis, bone_rest.origin * global_transform_scale_local))
		p_skeleton.set_bone_pose_position(src_idx, bone_rest.origin * global_transform_scale_local)
		p_skeleton.set_bone_pose_rotation(src_idx, bone_rest.basis.get_rotation_quaternion())
		p_skeleton.set_bone_pose_scale(src_idx, bone_rest.basis.get_scale())

	# TODO: Do animation tracks (vrm_animation)?
	return global_transform_scale_local


static func skeleton_rename(gstate: GLTFState, p_base_scene: Node, p_skeleton: Skeleton3D, p_bone_map: BoneMap):
	var original_bone_names_to_indices = {}
	var original_indices_to_bone_names = {}
	var original_indices_to_new_bone_names = {}
	var skellen: int = p_skeleton.get_bone_count()

	# Rename bones to their humanoid equivalents.
	for i in range(skellen):
		var bn: StringName = p_bone_map.find_profile_bone_name(p_skeleton.get_bone_name(i))
		original_bone_names_to_indices[p_skeleton.get_bone_name(i)] = i
		original_indices_to_bone_names[i] = p_skeleton.get_bone_name(i)
		original_indices_to_new_bone_names[i] = bn
		if bn != StringName():
			p_skeleton.set_bone_name(i, bn)

	var gnodes = gstate.nodes
	var root_bone_name = "Root"
	if p_skeleton.find_bone(root_bone_name) == -1:
		p_skeleton.add_bone(root_bone_name)
		var new_root_bone_id = p_skeleton.find_bone(root_bone_name)
		for root_bone_id in p_skeleton.get_parentless_bones():
			if root_bone_id != new_root_bone_id:
				p_skeleton.set_bone_parent(root_bone_id, new_root_bone_id)
	else:
		push_warning("VRM0: Root bone already found despite rename")
	for gnode in gnodes:
		var bn: StringName = p_bone_map.find_profile_bone_name(gnode.resource_name)
		if bn != StringName():
			gnode.resource_name = bn

	var nodes: Array[Node] = p_base_scene.find_children("*", "ImporterMeshInstance3D")
	while not nodes.is_empty():
		var mi: ImporterMeshInstance3D = nodes.pop_back() as ImporterMeshInstance3D
		var skin: Skin = mi.skin
		if skin:
			var node = mi.get_node(mi.skeleton_path)
			if node and node is Skeleton3D and node == p_skeleton:
				skellen = skin.get_bind_count()
				for i in range(skellen):
					# Bone name from skin (un-remapped bone name)
					var bind_bone_name: StringName = skin.get_bind_name(i)
					if bind_bone_name.is_empty():
						#bind_bone_name = node.get_bone_name(skin.get_bind_bone(i))
						if skin.get_bind_bone(i) != -1:
							break # Not using named binds: no need to rename skin.
					var bone_name_from_skel: StringName = p_bone_map.find_profile_bone_name(bind_bone_name)
					if not bone_name_from_skel.is_empty():
						skin.set_bind_name(i, bone_name_from_skel)

	# Rename bones in all Nodes by calling method.
	nodes = p_base_scene.find_children("*")

	p_skeleton.name = "GeneralSkeleton"
	p_skeleton.set_unique_name_in_owner(true)
	while not nodes.is_empty():
		var nd = nodes.pop_back()
		if nd.has_method(&"_notify_skeleton_bones_renamed"):
			nd.call(&"_notify_skeleton_bones_renamed", p_base_scene, p_skeleton, p_bone_map)


static func skeleton_rotate(p_base_scene: Node, src_skeleton: Skeleton3D, p_bone_map: BoneMap, old_skeleton_global_rest: Array[Transform3D]) -> Array[Basis]:
	# is_renamed: was skeleton_rename already invoked?
	var is_renamed = true
	var profile = p_bone_map.profile
	var prof_skeleton = Skeleton3D.new()
	for i in range(profile.bone_size):
		# Add single bones.
		prof_skeleton.add_bone(profile.get_bone_name(i))
		prof_skeleton.set_bone_rest(i, profile.get_reference_pose(i))
	for i in range(profile.bone_size):
		# Set parents.
		var parent = profile.find_bone(profile.get_bone_parent(i))
		if parent >= 0:
			prof_skeleton.set_bone_parent(i, parent)

	# Overwrite axis.
	var old_skeleton_rest: Array[Transform3D]
	old_skeleton_global_rest.clear()
	for i in range(src_skeleton.get_bone_count()):
		old_skeleton_rest.push_back(src_skeleton.get_bone_rest(i))
		old_skeleton_global_rest.push_back(src_skeleton.get_bone_global_rest(i))

	var diffs: Array[Basis]
	diffs.resize(src_skeleton.get_bone_count())

	# Short circuit the rotations
	if false:
		prof_skeleton.queue_free()
		return diffs

	var bones_to_process: PackedInt32Array = src_skeleton.get_parentless_bones()
	var bpidx = 0
	while bpidx < len(bones_to_process):
		var src_idx: int = bones_to_process[bpidx]
		bpidx += 1
		var src_children: PackedInt32Array = src_skeleton.get_bone_children(src_idx)
		for bone_idx in src_children:
			bones_to_process.push_back(bone_idx)

		var tgt_rot: Basis
		var src_bone_name: StringName = StringName(src_skeleton.get_bone_name(src_idx)) if is_renamed else p_bone_map.find_profile_bone_name(src_skeleton.get_bone_name(src_idx))
		if src_bone_name != StringName():
			var src_pg: Basis
			var src_parent_idx: int = src_skeleton.get_bone_parent(src_idx)
			if src_parent_idx >= 0:
				src_pg = src_skeleton.get_bone_global_rest(src_parent_idx).basis

			var prof_idx: int = profile.find_bone(src_bone_name)
			if prof_idx >= 0:
				tgt_rot = src_pg.inverse() * prof_skeleton.get_bone_global_rest(prof_idx).basis  # Mapped bone uses reference pose.

		if src_skeleton.get_bone_parent(src_idx) >= 0:
			diffs[src_idx] = (tgt_rot.inverse() * diffs[src_skeleton.get_bone_parent(src_idx)] * src_skeleton.get_bone_rest(src_idx).basis)
		else:
			diffs[src_idx] = tgt_rot.inverse() * src_skeleton.get_bone_rest(src_idx).basis

		var diff: Basis
		if src_skeleton.get_bone_parent(src_idx) >= 0:
			diff = diffs[src_skeleton.get_bone_parent(src_idx)]

		src_skeleton.set_bone_rest(src_idx, Transform3D(tgt_rot, diff * src_skeleton.get_bone_rest(src_idx).origin))

	prof_skeleton.queue_free()
	return diffs


static func apply_mesh_rotation(p_base_scene: Node, src_skeleton: Skeleton3D, old_skeleton_global_rest: Array[Transform3D], global_transform_scale_local: Vector3):
	# Fix skin.
	var scale_xform: Transform3D = Transform3D(Basis.from_scale(global_transform_scale_local), Vector3.ZERO)
	var nodes: Array[Node] = p_base_scene.find_children("*", "ImporterMeshInstance3D")
	var mutated_skins: Dictionary
	while not nodes.is_empty():
		var this_node = nodes.pop_back()
		if this_node is ImporterMeshInstance3D:
			var mi = this_node
			var skin: Skin = mi.skin
			var node = mi.get_node_or_null(mi.skeleton_path)
			if skin and node and node is Skeleton3D and node == src_skeleton:
				if mutated_skins.has(skin):
					continue
				mutated_skins[skin] = true
				var skellen = skin.get_bind_count()
				for i in range(skellen):
					var bn: StringName = skin.get_bind_name(i)
					if bn == &"":
						bn = node.get_bone_name(skin.get_bind_bone(i))
					var bone_idx: int = src_skeleton.find_bone(bn)
					if bone_idx >= 0:
						var adjust_transform: Transform3D = src_skeleton.get_bone_global_rest(bone_idx).affine_inverse() * old_skeleton_global_rest[bone_idx]
						adjust_transform = adjust_transform.scaled(global_transform_scale_local)
						# silhouette_diff[i] is not used because VRM files must be in T-Pose before export.
						skin.set_bind_pose(i, adjust_transform * skin.get_bind_pose(i))

	nodes = src_skeleton.get_children()
	while not nodes.is_empty():
		var attachment: BoneAttachment3D = nodes.pop_back() as BoneAttachment3D
		if attachment == null:
			continue
		var bone_idx: int = attachment.bone_idx
		if bone_idx == -1:
			bone_idx = src_skeleton.find_bone(attachment.bone_name)
		var adjust_transform: Transform3D = src_skeleton.get_bone_global_rest(bone_idx).affine_inverse() * old_skeleton_global_rest[bone_idx];
		adjust_transform = adjust_transform.scaled(global_transform_scale_local);

		var child_nodes: Array[Node] = attachment.get_children();
		while not child_nodes.is_empty():
			var child: Node3D = child_nodes.pop_back() as Node3D
			if child == null:
				continue
			child.transform = adjust_transform * child.transform

	# Init skeleton pose to new rest.
	for i in range(src_skeleton.get_bone_count()):
		var fixed_rest: Transform3D = src_skeleton.get_bone_rest(i)
		src_skeleton.set_bone_pose_position(i, fixed_rest.origin)
		src_skeleton.set_bone_pose_rotation(i, fixed_rest.basis.get_rotation_quaternion())
		src_skeleton.set_bone_pose_scale(i, fixed_rest.basis.get_scale())


static func perform_retarget(gstate: GLTFState, root_node: Node, skeleton: Skeleton3D, bone_map: BoneMap) -> Array[Basis]:
	var skeletonPath: NodePath = root_node.get_path_to(skeleton)
	var global_transform_scale_local: Vector3 = apply_node_transforms(root_node, skeleton)

	skeleton_rename(gstate, root_node, skeleton, bone_map)

	var old_skeleton_global_rest: Array[Transform3D]
	var poses = skeleton_rotate(root_node, skeleton, bone_map, old_skeleton_global_rest)
	apply_mesh_rotation(root_node, skeleton, old_skeleton_global_rest, global_transform_scale_local)

	var hips_bone_idx = skeleton.find_bone("Hips")
	if hips_bone_idx != -1:
		skeleton.motion_scale = abs(skeleton.get_bone_global_rest(hips_bone_idx).origin.y)
		if skeleton.motion_scale < 0.0001:
			skeleton.motion_scale = 1.0
	return poses


static func _recurse_bones(bones: Dictionary, skel: Skeleton3D, bone_idx: int):
	bones[skel.get_bone_name(bone_idx)] = bone_idx
	for child in skel.get_bone_children(bone_idx):
		_recurse_bones(bones, skel, child)


static func _generate_hide_bone_mesh(mesh: ImporterMesh, skin: Skin, bone_names_to_hide: Dictionary) -> ImporterMesh:
	var bind_indices_to_hide: Dictionary = {}

	for i in range(skin.get_bind_count()):
		var bind_name: StringName = skin.get_bind_name(i)
		if bind_name != &"":
			if bone_names_to_hide.has(bind_name):
				bind_indices_to_hide[i] = true
		else:  # non-named binds???
			if bone_names_to_hide.values().count(skin.get_bind_bone(i)) != 0:
				bind_indices_to_hide[i] = true

	# MESH and SKIN data divide, to compensate for object position multiplying.
	var surf_count: int = mesh.get_surface_count()
	var surf_data_by_mesh = [].duplicate()
	var blendshapes = []
	for bsidx in mesh.get_blend_shape_count():
		blendshapes.append(mesh.get_blend_shape_name(bsidx))
	var did_hide_any_surface_verts: bool = false
	for surf_idx in range(surf_count):
		var prim: int = mesh.get_surface_primitive_type(surf_idx)
		var fmt_compress_flags: int = mesh.get_surface_format(surf_idx)
		var arr: Array = mesh.get_surface_arrays(surf_idx).duplicate(true)
		var name: String = mesh.get_surface_name(surf_idx)
		var bscount = mesh.get_blend_shape_count()
		var bsarr: Array[Array] = []
		for bsidx in range(bscount):
			bsarr.append(mesh.get_surface_blend_shape_arrays(surf_idx, bsidx).duplicate(true))
		var lods: Dictionary = {}  # mesh.surface_get_lods(surf_idx) # get_lods(mesh, surf_idx)
		var mat: Material = mesh.get_surface_material(surf_idx)
		var vert_arr_len: int = len(arr[ArrayMesh.ARRAY_VERTEX])
		var hide_verts: PackedInt32Array
		hide_verts.resize(vert_arr_len)
		var did_hide_verts: bool = false
		if typeof(arr[ArrayMesh.ARRAY_BONES]) == TYPE_PACKED_INT32_ARRAY:
			var bonearr: PackedInt32Array = arr[ArrayMesh.ARRAY_BONES]
			var bones_per_vert = len(bonearr) / vert_arr_len
			var outidx = 0
			for i in range(vert_arr_len):
				var keepvert = true
				for j in range(bones_per_vert):
					if bind_indices_to_hide.has(bonearr[i * bones_per_vert + j]):
						hide_verts[i] = 1
						did_hide_verts = true
						did_hide_any_surface_verts = true
						break
		if did_hide_verts and prim == Mesh.PRIMITIVE_TRIANGLES:
			var indexarr: PackedInt32Array = arr[ArrayMesh.ARRAY_INDEX]
			var new_indexarr: PackedInt32Array = PackedInt32Array()
			var cnt: int = 0
			for i in range(0, len(indexarr) - 2, 3):
				if hide_verts[indexarr[i]] == 0 && hide_verts[indexarr[i + 1]] == 0 && hide_verts[indexarr[i + 2]] == 0:
					cnt += 3
			if cnt == 0:
				continue  # We skip this primitive entirely.
			new_indexarr.resize(cnt)
			cnt = 0
			for i in range(0, len(indexarr) - 2, 3):
				if hide_verts[indexarr[i]] == 0 && hide_verts[indexarr[i + 1]] == 0 && hide_verts[indexarr[i + 2]] == 0:
					new_indexarr[cnt] = indexarr[i]
					new_indexarr[cnt + 1] = indexarr[i + 1]
					new_indexarr[cnt + 2] = indexarr[i + 2]
					cnt += 3
			arr[ArrayMesh.ARRAY_INDEX] = new_indexarr

		surf_data_by_mesh.push_back({"prim": prim, "arr": arr, "bsarr": bsarr, "lods": lods, "fmt_compress_flags": fmt_compress_flags, "name": name, "mat": mat})

	if len(surf_data_by_mesh) == 0:  # all primitives were gobbled up
		return null
	if not did_hide_any_surface_verts:
		return mesh

	var new_mesh: ImporterMesh = ImporterMesh.new()
	new_mesh.set_blend_shape_mode(mesh.get_blend_shape_mode())
	new_mesh.set_lightmap_size_hint(mesh.get_lightmap_size_hint())
	new_mesh.resource_name = mesh.resource_name + "_HeadHidden"
	for blend_name in blendshapes:
		new_mesh.add_blend_shape(blend_name)
	for surf_idx in range(len(surf_data_by_mesh)):
		var prim: int = surf_data_by_mesh[surf_idx].get("prim")
		var arr: Array = surf_data_by_mesh[surf_idx].get("arr")
		var bsarr: Array[Array] = surf_data_by_mesh[surf_idx].get("bsarr")
		var lods: Dictionary = surf_data_by_mesh[surf_idx].get("lods")
		var fmt_compress_flags: int = surf_data_by_mesh[surf_idx].get("fmt_compress_flags")
		var name: String = surf_data_by_mesh[surf_idx].get("name")
		var mat: Material = surf_data_by_mesh[surf_idx].get("mat")
		new_mesh.add_surface(prim, arr, bsarr, lods, mat, name, fmt_compress_flags)
	return new_mesh
