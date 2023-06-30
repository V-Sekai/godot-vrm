extends GLTFDocumentExtension

const vrm_constants_class = preload("../vrm_constants.gd")
const vrm_meta_class = preload("../vrm_meta.gd")
const vrm_top_level = preload("../vrm_toplevel.gd")

var vrm_meta: Resource = null

func skeleton_rename(gstate: GLTFState, p_base_scene: Node, p_skeleton: Skeleton3D, p_bone_map: BoneMap):
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
	for gnode in gnodes:
		var bn: StringName = p_bone_map.find_profile_bone_name(gnode.resource_name)
		if bn != StringName():
			gnode.resource_name = bn

	var nodes: Array[Node] = p_base_scene.find_children("*", "ImporterMeshInstance3D")
	while not nodes.is_empty():
		var mi : ImporterMeshInstance3D = nodes.pop_back() as ImporterMeshInstance3D
		var skin: Skin = mi.skin
		if skin:
			var node = mi.get_node(mi.skeleton_path)
			if node and node is Skeleton3D and node == p_skeleton:
				skellen = skin.get_bind_count()
				for i in range(skellen):
					# Bone name from skin (un-remapped bone name)
					var bind_bone_name = skin.get_bind_name(i)
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

func skeleton_rotate(p_base_scene: Node, src_skeleton: Skeleton3D, p_bone_map: BoneMap) -> Array[Basis]:
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
	var old_skeleton_global_rest: Array[Transform3D]
	for i in range(src_skeleton.get_bone_count()):
		old_skeleton_rest.push_back(src_skeleton.get_bone_rest(i))
		old_skeleton_global_rest.push_back(src_skeleton.get_bone_global_rest(i))

	var diffs: Array[Basis]
	diffs.resize(src_skeleton.get_bone_count())

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


func apply_rotation(p_base_scene: Node, src_skeleton: Skeleton3D):
	# Fix skin.
	var nodes: Array[Node] = p_base_scene.find_children("*", "ImporterMeshInstance3D")
	while not nodes.is_empty():
		var this_node = nodes.pop_back()
		if this_node is ImporterMeshInstance3D:
			var mi = this_node
			var skin: Skin = mi.skin
			var node = mi.get_node_or_null(mi.skeleton_path)
			if skin and node and node is Skeleton3D and node == src_skeleton:
				var skellen = skin.get_bind_count()
				for i in range(skellen):
					var bn: StringName = skin.get_bind_name(i)
					var bone_idx: int = src_skeleton.find_bone(bn)
					if bone_idx >= 0:
						# silhouette_diff[i] *
						# Normally would need to take bind-pose into account.
						# However, in this case, it works because VRM files must be baked before export.
						var new_rest: Transform3D = src_skeleton.get_bone_global_rest(bone_idx)
						skin.set_bind_pose(i, new_rest.inverse())

	# Init skeleton pose to new rest.
	for i in range(src_skeleton.get_bone_count()):
		var fixed_rest: Transform3D = src_skeleton.get_bone_rest(i)
		src_skeleton.set_bone_pose_position(i, fixed_rest.origin)
		src_skeleton.set_bone_pose_rotation(i, fixed_rest.basis.get_rotation_quaternion())
		src_skeleton.set_bone_pose_scale(i, fixed_rest.basis.get_scale())




func _get_skel_godot_node(gstate: GLTFState, nodes: Array, skeletons: Array, skel_id: int) -> Node:
	# There's no working direct way to convert from skeleton_id to node_id.
	# Bugs:
	# GLTFNode.parent is -1 if skeleton bone.
	# skeleton_to_node is empty
	# get_scene_node(skeleton bone) works though might maybe return an attachment.
	# var skel_node_idx = nodes[gltfskel.roots[0]]
	# return gstate.get_scene_node(skel_node_idx) # as Skeleton
	for i in range(nodes.size()):
		if nodes[i].skeleton == skel_id:
			return gstate.get_scene_node(i)
	return null


class SkelBone:
	var skel: Skeleton3D
	var bone_name: String


# https://github.com/vrm-c/vrm-specification/blob/master/specification/0.0/schema/vrm.humanoid.bone.schema.json
# vrm_extension["humanoid"]["bone"]:
#"enum": ["hips","leftUpperLeg","rightUpperLeg","leftLowerLeg","rightLowerLeg","leftFoot","rightFoot",
# "spine","chest","neck","head","leftShoulder","rightShoulder","leftUpperArm","rightUpperArm",
# "leftLowerArm","rightLowerArm","leftHand","rightHand","leftToes","rightToes","leftEye","rightEye","jaw",
# "leftThumbProximal","leftThumbIntermediate","leftThumbDistal",
# "leftIndexProximal","leftIndexIntermediate","leftIndexDistal",
# "leftMiddleProximal","leftMiddleIntermediate","leftMiddleDistal",
# "leftRingProximal","leftRingIntermediate","leftRingDistal",
# "leftLittleProximal","leftLittleIntermediate","leftLittleDistal",
# "rightThumbProximal","rightThumbIntermediate","rightThumbDistal",
# "rightIndexProximal","rightIndexIntermediate","rightIndexDistal",
# "rightMiddleProximal","rightMiddleIntermediate","rightMiddleDistal",
# "rightRingProximal","rightRingIntermediate","rightRingDistal",
# "rightLittleProximal","rightLittleIntermediate","rightLittleDistal", "upperChest"]


func _create_meta(
	root_node: Node,
	animplayer: AnimationPlayer,
	vrm_extension: Dictionary,
	gstate: GLTFState,
	skeleton: Skeleton3D,
	humanBones: BoneMap,
	human_bone_to_idx: Dictionary,
	pose_diffs: Array[Basis]
) -> Resource:
	var nodes = gstate.get_nodes()

	#var skeletonPath: NodePath = root_node.get_path_to(skeleton)
	#root_node.set("vrm_skeleton", skeletonPath)

	#var animPath: NodePath = root_node.get_path_to(animplayer)
	#root_node.set("vrm_animplayer", animPath)

	var firstperson = vrm_extension.get("lookAt", null)
	var eyeOffset: Vector3

	if firstperson:
		# FIXME: Technically this is supposed to be offset relative to the "firstPersonBone"
		# However, firstPersonBone defaults to Head...
		# and the semantics of a VR player having their viewpoint out of something which does
		# not rotate with their head is unclear.
		# Additionally, the spec schema says this:
		# "It is assumed that an offset from the head bone to the VR headset is added."
		# Which implies that the Head bone is used, not the firstPersonBone.
		var fpboneoffsetxyz = firstperson["offsetFromHeadBone"]  # example: 0,0.06,0
		eyeOffset = Vector3(fpboneoffsetxyz[0], fpboneoffsetxyz[1], fpboneoffsetxyz[2])
		if human_bone_to_idx["head"] != -1:
			eyeOffset = pose_diffs[human_bone_to_idx["head"]] * eyeOffset

	vrm_meta = vrm_meta_class.new()

	vrm_meta.resource_name = "CLICK TO SEE METADATA"
	vrm_meta.spec_version = vrm_extension.get("specVersion", "1.0")
	var vrm_extension_meta = vrm_extension.get("meta")
	if vrm_extension_meta:
		vrm_meta.title = vrm_extension["meta"].get("name", "")
		vrm_meta.version = vrm_extension["meta"].get("version", "")
		vrm_meta.authors = PackedStringArray(vrm_extension["meta"].get("authors", []))
		vrm_meta.contact_information = vrm_extension["meta"].get("contactInformation", "")
		vrm_meta.references = PackedStringArray(vrm_extension["meta"].get("references", []))
		var tex: int = vrm_extension["meta"].get("thumbnailImage", -1)
		if tex >= 0:
			vrm_meta.thumbnail_image = gstate.get_images()[tex]
		var avatar_permission_map = {"": "", "onlyAuthor": "OnlyAuthor", "onlySeparatelyLicensedPerson": "ExplicitlyLicensedPerson", "everyone": "Everyone"}
		vrm_meta.allowed_user_name = avatar_permission_map[vrm_extension["meta"].get("avatarPermission", "")]
		vrm_meta.violent_usage = "Allow" if vrm_extension["meta"].get("allowExcessivelyViolentUsage", false) else "Disallow"
		vrm_meta.sexual_usage = "Allow" if vrm_extension["meta"].get("allowExcessivelySexualUsage", false) else "Disallow"
		var commercial_usage_map = {"": "", "personalNonProfit": "PersonalNonProfit", "personalProfit": "PersonalProfit", "corporation": "AllowCorporation"}
		vrm_meta.commercial_usage_type = commercial_usage_map[vrm_extension["meta"].get("commercialUsage", "")]
		vrm_meta.political_religious_usage = "Allow" if vrm_extension["meta"].get("allowPoliticalOrReligiousUsage", false) else "Disallow"
		vrm_meta.antisocial_hate_usage = "Allow" if vrm_extension["meta"].get("allowAntisocialOrHateUsage", false) else "Disallow"
		var credit_notation_map = {"": "", "required": "Required", "unnecessary": "Unnecessary"}
		vrm_meta.credit_notation = credit_notation_map[vrm_extension["meta"].get("creditNotation", "")]
		vrm_meta.allow_redistribution = "Allow" if vrm_extension["meta"].get("allowRedistribution", false) else "Disallow"
		var modification_map = {"prohibited": "Prohibited", "allowModification": "AllowModification", "allowModificationRedistribution": "AllowModificationRedistribution"}
		vrm_meta.modification = modification_map[vrm_extension["meta"].get("modification", "")]
		vrm_meta.license_name = vrm_extension["meta"].get("licenseName", "")
		vrm_meta.license_url = vrm_extension["meta"].get("licenseUrl", "")
		vrm_meta.third_party_licenses = vrm_extension["meta"].get("thirdPartyLicenses", "")
		vrm_meta.other_license_url = vrm_extension["meta"].get("otherLicenseUrl", "")

	vrm_meta.eye_offset = eyeOffset
	vrm_meta.humanoid_bone_mapping = humanBones
	return vrm_meta


const vrm_animation_to_look_at : Dictionary = {
		"lookLeft": "rangeMapHorizontalOuter",
		"lookRight": "rangeMapHorizontalOuter",
		"lookDown": "rangeMapVerticalDown",
		"lookUp": "rangeMapVerticalUp",
	}
const vrm_animation_presets: Dictionary = {
		"happy": true,
		"angry": true,
		"sad": true,
		"relaxed": true,
		"surprised": true,
		"aa": true,
		"ih": true,
		"ou": true,
		"ee": true,
		"oh": true,
		"blink": true,
		"blinkLeft": true,
		"blinkRight": true,
		"lookUp": true,
		"lookDown": true,
		"lookLeft": true,
		"lookRight": true,
		"neutral": true,
}

func _create_animation(default_values: Dictionary, default_blend_shapes: Dictionary, anim_name: String, expression: Dictionary, animplayer: AnimationPlayer, gstate: GLTFState, material_idx_to_mesh_and_surface_idx: Dictionary, mesh_idx_to_meshinstance: Dictionary, node_to_head_hidden_node: Dictionary, look_at: Dictionary):
	#print("Blend shape group: " + shape["name"])
	var anim = Animation.new()
	anim.resource_name = anim_name

	var extra_weight: float = 1.0
	var input_key: float = 0.0
	if vrm_animation_to_look_at.has(anim_name):
		extra_weight = look_at.get(vrm_animation_to_look_at[anim_name], {}).get("outputScale", 1.0)
		input_key = look_at.get(vrm_animation_to_look_at[anim_name], {}).get("inputMaxValue") / 180.0

	var interpolation_type = Animation.INTERPOLATION_NEAREST if bool(expression["isBinary"]) else Animation.INTERPOLATION_LINEAR
	anim.set_meta("vrm_is_binary", expression["isBinary"])
	for textransformbind in expression.get("textureTransformBinds", []):
		var mesh_and_surface_idx = material_idx_to_mesh_and_surface_idx[int(textransformbind["material"])]
		var node: ImporterMeshInstance3D = mesh_idx_to_meshinstance[mesh_and_surface_idx[0]]
		var surface_idx = mesh_and_surface_idx[1]
		var mat: Material = node.mesh.get_surface_material(surface_idx)
		var scale = textransformbind["scale"]
		var offset = textransformbind["offset"]
		var newvalue1: Variant
		var origvalue1: Variant
		var property_path1: String

		var newvalue2: Variant
		var origvalue2: Variant
		var property_path2: String

		if mat is ShaderMaterial:
			var smat: ShaderMaterial = mat
			var param = smat.get_shader_parameter("_MainTex_ST")
			if param is Vector4:
				newvalue1 = Vector4(scale[0], scale[1], offset[0], offset[1])
				newvalue2 = newvalue1
				origvalue1 = param
				origvalue2 = param
				property_path1 = "shader_parameter/_MainTex_ST"
				if smat.next_pass != null:
					property_path2 = "next_pass:" + property_path1
			else:
				printerr("Unknown type for tex transform parameter" + " surface " + node.name + "/" + str(surface_idx))
		elif mat is BaseMaterial3D:
			var smat: BaseMaterial3D = mat
			property_path1 = "uv1_offset"
			origvalue1 = smat.uv1_offset
			newvalue1 = Vector3(offset[0], offset[1], 0)
			property_path2 = "uv1_scale"
			origvalue2 = smat.uv1_scale
			newvalue2 = Vector3(scale[0], scale[1], 0)

		if not property_path1.is_empty():
			var animtrack: int = anim.add_track(Animation.TYPE_VALUE)
			var anim_path = str(animplayer.get_parent().get_path_to(node)) + ":mesh:surface_" + str(surface_idx) + "/material:" + property_path1
			anim.track_set_path(animtrack, anim_path)
			anim.track_set_interpolation_type(animtrack, interpolation_type)
			anim.track_insert_key(animtrack, input_key, origvalue1.lerp(newvalue1, extra_weight))
			default_values[anim_path] = origvalue1
		if not property_path2.is_empty():
			var animtrack: int = anim.add_track(Animation.TYPE_VALUE)
			var anim_path = str(animplayer.get_parent().get_path_to(node)) + ":mesh:surface_" + str(surface_idx) + "/material:" + property_path2
			anim.track_set_path(animtrack, anim_path)
			anim.track_set_interpolation_type(animtrack, interpolation_type)
			anim.track_insert_key(animtrack, input_key, origvalue2.lerp(newvalue2, extra_weight))
			default_values[anim_path] = origvalue2

	for matbind in expression.get("materialColorBinds", []):
		var mesh_and_surface_idx = material_idx_to_mesh_and_surface_idx[matbind["material"]]
		var node: ImporterMeshInstance3D = mesh_idx_to_meshinstance[mesh_and_surface_idx[0]]
		var surface_idx = mesh_and_surface_idx[1]

		var mat: Material = node.get_surface_material(surface_idx)
		var tv: Array = matbind["targetValue"]
		var property_path: String = ""
		var newvalue: Color = Color(tv[0], tv[1], tv[2], tv[3])
		if matbind["type"] != "color" and matbind["type"] != "outlineColor":
			newvalue.a = 1.0
		var origvalue: Color

		if mat is ShaderMaterial:
			var smat: ShaderMaterial = mat
			var property_mapping = {
				"color": "_Color",
				"emissionColor": "_EmissionColor",
				"shadeColor": "_ShadeColor",
				"matcapColor": "_SphereColor",
				"rimColor": "_RimColor",
				"outlineColor": "_OutlineColor",
			}
			var param = smat.get_shader_parameter(property_mapping.get(matbind["type"], matbind["type"]))
			if param is Color:
				origvalue = param
				property_path = "shader_parameter/" + property_mapping.get(matbind["type"], matbind["type"])
				if matbind["type"] == "outlineColor":
					property_path = "next_pass:" + property_path
			else:
				printerr("Unknown type for parameter " + matbind["type"] + " surface " + node.name + "/" + str(surface_idx))
		elif mat is BaseMaterial3D:
			var smat: BaseMaterial3D = mat
			if matbind["type"] == "color":
				property_path = "albedo_color"
				origvalue = mat.albedo_color
			elif matbind["type"] == "emissionColor":
				property_path = "emission"
				origvalue = mat.emission

		if not property_path.is_empty():
			var animtrack: int = anim.add_track(Animation.TYPE_VALUE)
			var anim_path = str(animplayer.get_parent().get_path_to(node)) + ":mesh:surface_" + str(surface_idx) + "/material:" + property_path
			anim.track_set_path(animtrack, anim_path)
			anim.track_set_interpolation_type(animtrack, interpolation_type)
			anim.track_insert_key(animtrack, input_key, origvalue.lerp(newvalue, extra_weight))
			default_values[anim_path] = origvalue
	for bind in expression.get("morphTargetBinds", []):
		# FIXME: Is this a mesh_idx or a node_idx???
		var node_maybe: Node = gstate.get_scene_node(int(bind["node"]))
		if not node_maybe is ImporterMeshInstance3D:
			push_warning("Morph target bind is a " + str(node_maybe.get_class()))
			continue
		var node: ImporterMeshInstance3D = node_maybe as ImporterMeshInstance3D
		var nodeMesh: ImporterMesh = node.mesh

		if bind["index"] < 0 || bind["index"] >= nodeMesh.get_blend_shape_count():
			printerr("Invalid blend shape index in bind " + str(expression) + " for mesh " + str(node.name))
			continue
		var animtrack: int = anim.add_track(Animation.TYPE_BLEND_SHAPE)
		# nodeMesh.set_blend_shape_name(int(bind["index"]), shape["name"] + "_" + str(bind["index"]))
		var anim_path: String = str(animplayer.get_parent().get_path_to(node)) + ":" + str(nodeMesh.get_blend_shape_name(int(bind["index"])))
		anim.track_set_path(animtrack, anim_path)
		anim.track_set_interpolation_type(animtrack, interpolation_type)
		# FIXME: Godot has weird normal/tangent singularities at weight=1.0 or weight=0.5
		anim.blend_shape_track_insert_key(animtrack, input_key, 0.99999 * float(bind["weight"]) / 100.0)
		#var mesh:ArrayMesh = meshes[bind["mesh"]].mesh
		#print("Mesh name: " + mesh.resource_name)
		#print("Bind index: " + str(bind["index"]))
		#print("Bind weight: " + str(float(bind["weight"]) / 100.0))
		var head_hidden_node: ImporterMeshInstance3D = node_to_head_hidden_node.get(node, null)
		if head_hidden_node != null:
			animtrack = anim.add_track(Animation.TYPE_BLEND_SHAPE)
			# nodeMesh.set_blend_shape_name(int(bind["index"]), shape["name"] + "_" + str(bind["index"]))
			anim_path = str(animplayer.get_parent().get_path_to(head_hidden_node)) + ":" + str(nodeMesh.get_blend_shape_name(int(bind["index"])))
			anim.track_set_path(animtrack, anim_path)
			anim.track_set_interpolation_type(animtrack, interpolation_type)
			# FIXME: Godot has weird normal/tangent singularities at weight=1.0 or weight=0.5
			anim.blend_shape_track_insert_key(animtrack, input_key, extra_weight * 0.99999 * float(bind["weight"]) / 100.0)
			default_blend_shapes[anim_path] = 0.0 # TODO: Find the default value from gltf??

	return anim

func _recurse_bones(bones: Dictionary, skel: Skeleton3D, bone_idx: int):
	bones[skel.get_bone_name(bone_idx)] = bone_idx
	for child in skel.get_bone_children(bone_idx):
		_recurse_bones(bones, skel, child)


func _generate_hide_bone_mesh(mesh: ImporterMesh, skin: Skin, bone_names_to_hide: Dictionary) -> ImporterMesh:
	var bind_indices_to_hide: Dictionary = {}
	
	for i in range(skin.get_bind_count()):
		var bind_name: StringName = skin.get_bind_name(i)
		if bind_name != &"":
			if bone_names_to_hide.has(bind_name):
				bind_indices_to_hide[bone_names_to_hide[bind_name]] = true
		else: # non-named binds???
			if bone_names_to_hide.values().count(skin.get_bind_bone(i)) != 0:
				bind_indices_to_hide[bone_names_to_hide[bind_name]] = true

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
		var arr: Array = mesh.get_surface_arrays(surf_idx)
		var name: String = mesh.get_surface_name(surf_idx)
		var bscount = mesh.get_blend_shape_count()
		var bsarr: Array[Array] = []
		for bsidx in range(bscount):
			bsarr.append(mesh.get_surface_blend_shape_arrays(surf_idx, bsidx))
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
					if bind_indices_to_hide.has(bonearr[i + j * bones_per_vert]):
						hide_verts[i] = 1
						did_hide_verts = true
						did_hide_any_surface_verts = true
						break
		if did_hide_verts and prim == Mesh.PRIMITIVE_TRIANGLES:
			var indexarr: PackedInt32Array = arr[ArrayMesh.ARRAY_INDEX]
			var new_indexarr: PackedInt32Array = PackedInt32Array()
			for i in range(0, len(indexarr) - 2, 3):
				if hide_verts[indexarr[i]] == 0 && hide_verts[indexarr[i + 1]] == 0 && hide_verts[indexarr[i + 2]] == 0:
					new_indexarr.append(indexarr[i])
					new_indexarr.append(indexarr[i + 1])
					new_indexarr.append(indexarr[i + 2])
			arr[ArrayMesh.ARRAY_INDEX] = new_indexarr
			if new_indexarr.is_empty():
				continue # We skip this primitive entirely.

		surf_data_by_mesh.push_back({"prim": prim, "arr": arr, "bsarr": bsarr, "lods": lods, "fmt_compress_flags": fmt_compress_flags, "name": name, "mat": mat})

	if len(surf_data_by_mesh) == 0: # all primitives were gobbled up
		return null
	if not did_hide_any_surface_verts:
		return mesh

	var new_mesh: ImporterMesh = ImporterMesh.new()
	new_mesh.set_blend_shape_mode(mesh.get_blend_shape_mode())
	new_mesh.set_lightmap_size_hint(mesh.get_lightmap_size_hint())
	new_mesh.resource_name = mesh.resource_name
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


func _create_animation_player(
	animplayer: AnimationPlayer, vrm_extension: Dictionary, gstate: GLTFState, human_bone_to_idx: Dictionary, pose_diffs: Array[Basis]
) -> AnimationPlayer:
	# Remove all glTF animation players for safety.
	# VRM does not support animation import in this way.
	for i in range(gstate.get_animation_players_count(0)):
		var node: AnimationPlayer = gstate.get_animation_player(i)
		node.get_parent().remove_child(node)

	var animation_library: AnimationLibrary = AnimationLibrary.new()

	var materials = gstate.get_materials()
	var meshes = gstate.get_meshes()
	var nodes = gstate.get_nodes()

	var firstperson = vrm_extension.get("firstPerson", {})
	var lookAt = vrm_extension.get("lookAt", {})

	var skeletons: Array = gstate.get_skeletons()

	var head_relative_bones: Dictionary = {} # To determine which meshes to hide.

	var mesh_to_head_hidden_mesh: Dictionary = {}
	var node_to_head_hidden_node: Dictionary = {}

	var lefteye: int = human_bone_to_idx.get("leftEye", -1)
	var righteye: int = human_bone_to_idx.get("rightEye", -1)

	var head_bone_idx = firstperson.get("firstPersonBone", -1)
	if head_bone_idx >= 0:
		var headNode: GLTFNode = nodes[head_bone_idx]
		var skel: Skeleton3D = _get_skel_godot_node(gstate, nodes, skeletons, headNode.skeleton)

		var head_attach: BoneAttachment3D = null
		for child in skel.find_children("*", "BoneAttachment3D"):
			var child_attach: BoneAttachment3D = child as BoneAttachment3D
			if child_attach.bone_name == "Head":
				head_attach = child_attach
				break
		if head_attach == null:
			head_attach = BoneAttachment3D.new()
			head_attach.name = "Head"
			skel.add_child(head_attach)
			head_attach.owner = skel.owner
			head_attach.bone_name = "Head"
			var head_bone_offset: Node3D = Node3D.new()
			head_bone_offset.name = "LookOffset"
			head_attach.add_child(head_bone_offset)
			head_bone_offset.unique_name_in_owner = true
			head_bone_offset.owner = skel.owner
			var look_offset = Vector3(0,0,0)
			if lookAt.has("offsetFromHeadBone"):
				var gltf_look_offset = lookAt["offsetFromHeadBone"]
				look_offset = Vector3(gltf_look_offset[0], gltf_look_offset[1], gltf_look_offset[2])
			elif lefteye >= 0 and righteye >= 0:
				look_offset = skel.get_bone_rest(lefteye).origin.lerp(skel.get_bone_rest(righteye).origin, 0.5)
			head_bone_offset.position = look_offset

		_recurse_bones(head_relative_bones, skel, head_bone_idx)

	var mesh_annotations_by_node = {}
	for meshannotation in firstperson.get("meshAnnotations", []):
		mesh_annotations_by_node[int(meshannotation["node"])] = meshannotation

	for node_idx in range(len(nodes)):
		var gltf_node: GLTFNode = nodes[node_idx]
		var node: Node = gstate.get_scene_node(node_idx)
		if node is ImporterMeshInstance3D:
			var meshannotation = mesh_annotations_by_node.get(node_idx, {})

			var flag: String = meshannotation.get("firstPersonFlag", "auto")

			# Non-skinned meshes: use flag.
			var mesh: ImporterMesh = node.mesh
			var head_hidden_mesh: ImporterMesh = mesh
			if flag == "auto":
				if node.skin == null:
					var parent_node = node.get_parent()
					if parent_node is BoneAttachment3D:
						if head_relative_bones.has(parent_node.bone_name):
							flag = "thirdPersonOnly"
				else:
					head_hidden_mesh = _generate_hide_bone_mesh(mesh, node.skin, head_relative_bones)
					if head_hidden_mesh == null:
						flag = "thirdPersonOnly"
					if head_hidden_mesh == mesh:
						flag = "both" # Nothing to do: No head verts.

			var layer_mask: int = 6 # "both"
			if flag == "thirdPersonOnly":
				layer_mask = 4
			elif flag == "firstPersonOnly":
				layer_mask = 2
				
			if flag == "auto": # If it is still "auto", we have something to hide.
				mesh_to_head_hidden_mesh[mesh] = head_hidden_mesh
				var head_hidden_node: ImporterMeshInstance3D = ImporterMeshInstance3D.new()
				head_hidden_node.name = node.name + " (Headless)"
				head_hidden_node.skin = node.skin
				head_hidden_node.mesh = head_hidden_mesh
				head_hidden_node.skeleton_path = node.skeleton_path
				head_hidden_node.owner = node.owner
				head_hidden_node.set_meta("layers", 2) # ImporterMeshInstance3D is missing APIs.
				node.add_sibling(head_hidden_node)
				gstate.meshes.append(head_hidden_mesh)
				node_to_head_hidden_node[node] = head_hidden_node
				layer_mask = 4

			node.set_meta("layers", layer_mask) # ImporterMeshInstance3D is missing APIs.


	var expressions = vrm_extension.get("expressions", {})
	# FIXME: Do we need to handle multiple references to the same mesh???
	var mesh_idx_to_meshinstance: Dictionary = {}
	var material_idx_to_mesh_and_surface_idx: Dictionary = {}
	var material_to_idx: Dictionary = {}
	for i in range(materials.size()):
		material_to_idx[materials[i]] = i
	for i in range(meshes.size()):
		var gltfmesh: GLTFMesh = meshes[i]
		for j in range(gltfmesh.mesh.get_surface_count()):
			material_idx_to_mesh_and_surface_idx[material_to_idx[gltfmesh.mesh.get_surface_material(j)]] = [i, j]

	for i in range(nodes.size()):
		var gltfnode: GLTFNode = nodes[i]
		var mesh_idx: int = gltfnode.mesh
		#print("node idx " + str(i) + " node name " + gltfnode.resource_name + " mesh idx " + str(mesh_idx))
		if mesh_idx != -1:
			var scenenode: ImporterMeshInstance3D = gstate.get_scene_node(i)
			mesh_idx_to_meshinstance[mesh_idx] = scenenode
			#print("insert " + str(mesh_idx) + " node name " + scenenode.name)

	var default_values: Dictionary = {}
	var default_blend_shapes: Dictionary = {}
	for expression_name in expressions.get("preset", {}):
		var expression = expressions["preset"][expression_name]
		if lookAt.get("type", "") != "bone" or not vrm_animation_to_look_at.has(expression_name):
			var anim: Animation = _create_animation(default_values, default_blend_shapes, expression_name, expression, animplayer, gstate, material_idx_to_mesh_and_surface_idx, mesh_idx_to_meshinstance, node_to_head_hidden_node, lookAt)
			# https://github.com/vrm-c/vrm-specification/tree/master/specification/0.0#blendshape-name-identifier
			animation_library.add_animation(expression_name, anim)
		if vrm_animation_to_look_at.has(expression_name):
			expression_name += "Raw"
			var anim: Animation = _create_animation(default_values, default_blend_shapes, expression_name, expression, animplayer, gstate, material_idx_to_mesh_and_surface_idx, mesh_idx_to_meshinstance, node_to_head_hidden_node, {})
			# https://github.com/vrm-c/vrm-specification/tree/master/specification/0.0#blendshape-name-identifier
			animation_library.add_animation(expression_name, anim)
	for expression_name in expressions.get("custom", {}):
		if expressions["preset"].has(expression_name):
			continue
		if vrm_animation_to_look_at.has(expression_name):
			continue
		var expression = expressions["custom"][expression_name]
		var anim: Animation = _create_animation(default_values, default_blend_shapes, expression_name, expression, animplayer, gstate, material_idx_to_mesh_and_surface_idx, mesh_idx_to_meshinstance, node_to_head_hidden_node, lookAt)
		# https://github.com/vrm-c/vrm-specification/tree/master/specification/0.0#blendshape-name-identifier
		animation_library.add_animation(expression_name, anim)

	var leftEyePath: String = ""
	var rightEyePath: String = ""
	if lookAt.get("type", "") == "bone" and lefteye >= 0 and righteye >= 0:
		var leftEyeNode: GLTFNode = nodes[lefteye]
		var rightEyeNode: GLTFNode = nodes[righteye]
		var skeleton: Skeleton3D = _get_skel_godot_node(gstate, nodes, skeletons, leftEyeNode.skeleton)
		var skeletonPath: NodePath = animplayer.get_parent().get_path_to(skeleton)
		leftEyePath = (str(skeletonPath) + ":" + nodes[human_bone_to_idx["leftEye"]].resource_name)
		rightEyePath = (str(skeletonPath) + ":" + nodes[human_bone_to_idx["rightEye"]].resource_name)

	if lookAt.get("type", "") == "bone" and not leftEyePath.is_empty() and not rightEyePath.is_empty():
		var horizout = lookAt.get("rangeMapHorizontalOuter", {})
		var horizin = lookAt.get("rangeMapHorizontalOuter", {})
		var vertdown = lookAt.get("rangeMapVerticalDown", {})
		var vertup = lookAt.get("rangeMapVerticalUp", {})


		var anim: Animation = null
		var animtrack: int
		pose_diffs[lefteye] = Quaternion()
		pose_diffs[righteye] = Quaternion()
		anim = Animation.new()
		animation_library.add_animation("lookLeft", anim)
		animtrack = anim.add_track(Animation.TYPE_ROTATION_3D)
		anim.track_set_path(animtrack, leftEyePath)
		anim.track_set_interpolation_type(animtrack, Animation.INTERPOLATION_LINEAR)
		anim.rotation_track_insert_key(animtrack, horizout["inputMaxValue"] / 180.0,
			(pose_diffs[lefteye] * Basis(Vector3(0, 1, 0), horizout["outputScale"] * 3.14159 / 180.0)).get_rotation_quaternion())
		animtrack = anim.add_track(Animation.TYPE_ROTATION_3D)
		anim.track_set_path(animtrack, rightEyePath)
		anim.track_set_interpolation_type(animtrack, Animation.INTERPOLATION_LINEAR)
		anim.rotation_track_insert_key(animtrack, horizin["inputMaxValue"] / 180.0,
			(pose_diffs[righteye] * Basis(Vector3(0, 1, 0), horizin["outputScale"] * 3.14159 / 180.0)).get_rotation_quaternion())

		anim = Animation.new()
		animation_library.add_animation("lookRight", anim)
		animtrack = anim.add_track(Animation.TYPE_ROTATION_3D)
		anim.track_set_path(animtrack, leftEyePath)
		anim.track_set_interpolation_type(animtrack, Animation.INTERPOLATION_LINEAR)
		anim.rotation_track_insert_key(animtrack, horizout["inputMaxValue"] / 180.0,
			(pose_diffs[lefteye] * Basis(Vector3(0, 1, 0), -horizin["outputScale"] * 3.14159 / 180.0)).get_rotation_quaternion())
		animtrack = anim.add_track(Animation.TYPE_ROTATION_3D)
		anim.track_set_path(animtrack, rightEyePath)
		anim.track_set_interpolation_type(animtrack, Animation.INTERPOLATION_LINEAR)
		anim.rotation_track_insert_key(animtrack, horizin["inputMaxValue"] / 180.0,
			(pose_diffs[righteye] * Basis(Vector3(0, 1, 0), -horizout["outputScale"] * 3.14159 / 180.0)).get_rotation_quaternion())

		anim = Animation.new()
		animation_library.add_animation("lookUp", anim)
		animtrack = anim.add_track(Animation.TYPE_ROTATION_3D)
		anim.track_set_path(animtrack, leftEyePath)
		anim.track_set_interpolation_type(animtrack, Animation.INTERPOLATION_LINEAR)
		anim.rotation_track_insert_key(animtrack, horizout["inputMaxValue"] / 180.0,
			(pose_diffs[lefteye] * Basis(Vector3(1, 0, 0), vertup["outputScale"] * 3.14159 / 180.0)).get_rotation_quaternion())
		animtrack = anim.add_track(Animation.TYPE_ROTATION_3D)
		anim.track_set_path(animtrack, rightEyePath)
		anim.track_set_interpolation_type(animtrack, Animation.INTERPOLATION_LINEAR)
		anim.rotation_track_insert_key(animtrack, horizin["inputMaxValue"] / 180.0,
			(pose_diffs[righteye] * Basis(Vector3(1, 0, 0), vertup["outputScale"] * 3.14159 / 180.0)).get_rotation_quaternion())

		anim = Animation.new()
		animation_library.add_animation("lookDown", anim)
		animtrack = anim.add_track(Animation.TYPE_ROTATION_3D)
		anim.track_set_path(animtrack, leftEyePath)
		anim.track_set_interpolation_type(animtrack, Animation.INTERPOLATION_LINEAR)
		anim.rotation_track_insert_key(animtrack, horizout["inputMaxValue"] / 180.0,
			(pose_diffs[lefteye] * Basis(Vector3(1, 0, 0), -vertdown["outputScale"] * 3.14159 / 180.0)).get_rotation_quaternion())
		animtrack = anim.add_track(Animation.TYPE_ROTATION_3D)
		anim.track_set_path(animtrack, rightEyePath)
		anim.track_set_interpolation_type(animtrack, Animation.INTERPOLATION_LINEAR)
		anim.rotation_track_insert_key(animtrack, horizin["inputMaxValue"] / 180.0,
			(pose_diffs[righteye] * Basis(Vector3(1, 0, 0), -vertdown["outputScale"] * 3.14159 / 180.0)).get_rotation_quaternion())

	var reset_anim: Animation = Animation.new()
	reset_anim.resource_name = "RESET"
	for anim_path in default_values:
		var animtrack: int = reset_anim.add_track(Animation.TYPE_VALUE)
		reset_anim.track_set_path(animtrack, anim_path)
		reset_anim.track_insert_key(animtrack, 0.0, default_values[anim_path])
	for anim_path in default_blend_shapes:
		var animtrack: int = reset_anim.add_track(Animation.TYPE_BLEND_SHAPE)
		reset_anim.track_set_path(animtrack, anim_path)
		reset_anim.blend_shape_track_insert_key(animtrack, 0.0, default_blend_shapes[anim_path])

	if lookAt.get("type", "") == "bone" and not leftEyePath.is_empty() and not rightEyePath.is_empty():
		var animtrack = reset_anim.add_track(Animation.TYPE_ROTATION_3D)
		reset_anim.track_set_path(animtrack, leftEyePath)
		reset_anim.rotation_track_insert_key(animtrack, 0.0, pose_diffs[lefteye].get_rotation_quaternion() * Quaternion.IDENTITY)
		animtrack = reset_anim.add_track(Animation.TYPE_ROTATION_3D)
		reset_anim.track_set_path(animtrack, rightEyePath)
		reset_anim.rotation_track_insert_key(animtrack, 0.0, pose_diffs[righteye].get_rotation_quaternion() * Quaternion.IDENTITY)

	animation_library.add_animation(&"RESETx", reset_anim)

	animplayer.add_animation_library("", animation_library)
	return animplayer


func _add_joints_recursive(new_joints_set: Dictionary, gltf_nodes: Array, bone: int, include_child_meshes: bool = false) -> void:
	if bone < 0:
		return
	var gltf_node: Dictionary = gltf_nodes[bone]
	if not include_child_meshes and gltf_node.get("mesh", -1) != -1:
		return
	new_joints_set[bone] = true
	for child_node in gltf_node.get("children", []):
		if not new_joints_set.has(child_node):
			_add_joints_recursive(new_joints_set, gltf_nodes, int(child_node))


func _add_joint_set_as_skin(obj: Dictionary, new_joints_set: Dictionary) -> void:
	var new_joints = [].duplicate()
	for node in new_joints_set:
		new_joints.push_back(node)
	new_joints.sort()

	var new_skin: Dictionary = {"joints": new_joints}

	if not obj.has("skins"):
		obj["skins"] = [].duplicate()

	obj["skins"].push_back(new_skin)


func _add_vrm_nodes_to_skin(obj: Dictionary) -> bool:
	var vrm_extension: Dictionary = obj.get("extensions", {}).get("VRMC_vrm", {})
	if not vrm_extension.has("humanoid"):
		return false
	var new_joints_set = {}.duplicate()

	var human_bones: Dictionary = vrm_extension["humanoid"]["humanBones"]
	for human_bone in human_bones:
		_add_joints_recursive(new_joints_set, obj["nodes"], int(human_bones[human_bone]["node"]), false)

	_add_joint_set_as_skin(obj, new_joints_set)

	return true


func _import_preflight(gstate: GLTFState, extensions: PackedStringArray = PackedStringArray()) -> Error:
	if not extensions.has("VRMC_vrm"):
		return ERR_INVALID_DATA
	var gltf_json_parsed: Dictionary = gstate.json
	if not _add_vrm_nodes_to_skin(gltf_json_parsed):
		push_error("Failed to find vrm humanBones in VRMC_vrm extension")
		return ERR_INVALID_DATA
	return OK


func apply_retarget(gstate: GLTFState, root_node: Node, skeleton: Skeleton3D, bone_map: BoneMap) -> Array[Basis]:
	var skeletonPath: NodePath = root_node.get_path_to(skeleton)

	skeleton_rename(gstate, root_node, skeleton, bone_map)
	var hips_bone_idx = skeleton.find_bone("Hips")
	if hips_bone_idx != -1:
		skeleton.motion_scale = abs(skeleton.get_bone_global_rest(hips_bone_idx).origin.y)
		if skeleton.motion_scale < 0.0001:
			skeleton.motion_scale = 1.0

	var poses = skeleton_rotate(root_node, skeleton, bone_map)
	apply_rotation(root_node, skeleton)
	return poses


func _import_post(gstate: GLTFState, node: Node) -> Error:
	var gltf: GLTFDocument = GLTFDocument.new()
	var root_node: Node = node

	var gltf_json: Dictionary = gstate.json
	var vrm_extension: Dictionary = gltf_json["extensions"]["VRMC_vrm"]

	var human_bone_to_idx: Dictionary = {}
	# Ignoring in ["humanoid"]: armStretch, legStretch, upperArmTwist
	# lowerArmTwist, upperLegTwist, lowerLegTwist, feetSpacing,
	# and hasTranslationDoF
	var human_bones: Dictionary = vrm_extension["humanoid"]["humanBones"]
	for human_bone in human_bones:
		human_bone_to_idx[human_bone] = int(human_bones[human_bone]["node"])

	var skeletons = gstate.get_skeletons()
	var hipsNode: GLTFNode = gstate.nodes[human_bone_to_idx["hips"]]
	var skeleton: Skeleton3D = _get_skel_godot_node(gstate, gstate.nodes, skeletons, hipsNode.skeleton)
	var gltfnodes: Array = gstate.nodes

	var humanBones: BoneMap = BoneMap.new()
	humanBones.profile = SkeletonProfileHumanoid.new()

	var vrmconst_inst = vrm_constants_class.new(false)
	for humanBoneName in human_bone_to_idx:
		humanBones.set_skeleton_bone_name(vrmconst_inst.vrm_to_human_bone[humanBoneName], gltfnodes[human_bone_to_idx[humanBoneName]].resource_name)

	var do_retarget = true

	var pose_diffs: Array[Basis]
	if do_retarget:
		pose_diffs = apply_retarget(gstate, root_node, skeleton, humanBones)
	else:
		# resize is busted for TypedArray and crashes Godot
		for i in range(skeleton.get_bone_count()):
			pose_diffs.append(Basis.IDENTITY)

	skeleton.set_meta("vrm_pose_diffs", pose_diffs)

	var animplayer: AnimationPlayer
	if root_node.has_node("AnimationPlayer"):
		animplayer = root_node.get_node("AnimationPlayer")
	else:
		animplayer = AnimationPlayer.new()
		animplayer.name = "AnimationPlayer"
		root_node.add_child(animplayer, true)
		animplayer.owner = root_node
	_create_animation_player(animplayer, vrm_extension, gstate, human_bone_to_idx, pose_diffs)

	root_node.set_script(vrm_top_level)

	var vrm_meta: Resource = _create_meta(root_node, animplayer, vrm_extension, gstate, skeleton, humanBones, human_bone_to_idx, pose_diffs)
	root_node.set("vrm_meta", vrm_meta)
	root_node.set("vrm_secondary", NodePath())

	return OK
