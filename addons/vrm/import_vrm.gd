tool
extends EditorSceneImporter


enum DebugMode {
	None = 0,
	Normal = 1,
	LitShadeRate = 2,
}

enum OutlineColorMode {
	FixedColor = 0,
	MixedLighting = 1,
}

enum OutlineWidthMode {
	None = 0,
	WorldCoordinates = 1,
	ScreenCoordinates = 2,
}

enum RenderMode {
	Opaque = 0,
	Cutout = 1,
	Transparent = 2,
	TransparentWithZWrite = 3,
}

enum CullMode {
	Off = 0,
	Front = 1,
	Back = 2,
}

enum FirstPersonFlag {
	Auto, # Create headlessModel
	Both, # Default layer
	ThirdPersonOnly,
	FirstPersonOnly,
}
const FirstPersonParser: Dictionary = {
	"Auto": FirstPersonFlag.Auto,
	"Both": FirstPersonFlag.Both,
	"FirstPersonOnly": FirstPersonFlag.FirstPersonOnly,
	"ThirdPersonOnly": FirstPersonFlag.ThirdPersonOnly,
}


func _get_extensions():
	return ["vrm"]


func _get_import_flags():
	return EditorSceneImporter.IMPORT_SCENE


func _import_animation(path: String, flags: int, bake_fps: int) -> Animation:
	return Animation.new()


func _process_khr_material(orig_mat: SpatialMaterial, gltf_mat_props: Dictionary) -> Material:
	# VRM spec requires support for the KHR_materials_unlit extension.
	if gltf_mat_props.has("extensions"):
		# TODO: Implement this extension upstream.
		if gltf_mat_props["extensions"].has("KHR_materials_unlit"):
			# TODO: validate that this is sufficient.
			orig_mat.flags_unshaded = true
	return orig_mat


func _vrm_get_texture_info(gltf_images: Array, vrm_mat_props: Dictionary, unity_tex_name: String):
	var texture_info: Dictionary = {}
	texture_info["tex"] = null
	texture_info["offset"] = Vector3(0.0, 0.0, 0.0)
	texture_info["scale"] = Vector3(1.0, 1.0, 1.0)
	if vrm_mat_props["textureProperties"].has(unity_tex_name):
		var mainTexId: int = vrm_mat_props["textureProperties"][unity_tex_name]
		var mainTexImage: ImageTexture = gltf_images[mainTexId]
		texture_info["tex"] = mainTexImage
	if vrm_mat_props["vectorProperties"].has(unity_tex_name):
		var offsetScale: Array = vrm_mat_props["vectorProperties"][unity_tex_name]
		texture_info["offset"] = Vector3(offsetScale[0], offsetScale[1], 0.0)
		texture_info["scale"] = Vector3(offsetScale[2], offsetScale[3], 1.0)
	return texture_info


func _vrm_get_float(vrm_mat_props: Dictionary, key: String, def: float) -> float:
	return vrm_mat_props["floatProperties"].get(key, def)

 
func _process_vrm_material(orig_mat: SpatialMaterial, gltf_images: Array, vrm_mat_props: Dictionary) -> Material:
	var vrm_shader_name:String = vrm_mat_props["shader"]
	if vrm_shader_name == "VRM_USE_GLTFSHADER":
		return orig_mat # It's already correct!
	
	if (vrm_shader_name == "Standard" or
		vrm_shader_name == "UniGLTF/UniUnlit" or
		vrm_shader_name == "VRM/UnlitTexture" or
		vrm_shader_name == "VRM/UnlitCutout" or
		vrm_shader_name == "VRM/UnlitTransparent"):
		printerr("Unsupported legacy VRM shader " + vrm_shader_name + " on material " + orig_mat.resource_name)
		return orig_mat

	var maintex_info: Dictionary = _vrm_get_texture_info(gltf_images, vrm_mat_props, "_MainTex")

	if vrm_shader_name == "VRM/UnlitTransparentZWrite":
		if maintex_info["tex"] != null:
			orig_mat.albedo_texture = maintex_info["tex"]
			orig_mat.uv1_offset = maintex_info["offset"]
			orig_mat.uv1_scale = maintex_info["scale"]
		orig_mat.flags_unshaded = true
		orig_mat.params_depth_draw_mode = SpatialMaterial.DEPTH_DRAW_ALWAYS
		orig_mat.flags_no_depth_test = false
		orig_mat.params_blend_mode = SpatialMaterial.BLEND_MODE_MIX
		return orig_mat

	if vrm_shader_name != "VRM/MToon":
		printerr("Unknown VRM shader " + vrm_shader_name + " on material " + orig_mat.resource_name)
		return orig_mat


	# Enum(Off,0,Front,1,Back,2) _CullMode

	var outline_width_mode = int(vrm_mat_props["floatProperties"].get("_OutlineWidthMode", 0))
	var blend_mode = int(vrm_mat_props["floatProperties"].get("_BlendMode", 0))
	var cull_mode = int(vrm_mat_props["floatProperties"].get("_CullMode", 2))
	var outl_cull_mode = int(vrm_mat_props["floatProperties"].get("_OutlineCullMode", 1))
	if cull_mode == CullMode.Front || (outl_cull_mode != CullMode.Front && outline_width_mode != OutlineWidthMode.None):
		printerr("VRM Material " + orig_mat.resource_name + " has unsupported front-face culling mode: " +
			str(cull_mode) + "/" + str(outl_cull_mode))
	if outline_width_mode == OutlineWidthMode.ScreenCoordinates:
		printerr("VRM Material " + orig_mat.resource_name + " uses screenspace outlines.")


	var mtoon_shader_base_path = "res://MToonCompat/mtooncompat"

	var godot_outline_shader_name = null
	if outline_width_mode != OutlineWidthMode.None:
		godot_outline_shader_name = mtoon_shader_base_path + "_outline"

	var godot_shader_name = mtoon_shader_base_path
	if blend_mode == RenderMode.Opaque or blend_mode == RenderMode.Cutout:
		# NOTE: Cutout is not separately implemented due to code duplication.
		if cull_mode == CullMode.Off:
			godot_shader_name = mtoon_shader_base_path + "_cull_off"
	elif blend_mode == RenderMode.Transparent:
		godot_shader_name = mtoon_shader_base_path + "_trans"
		if cull_mode == CullMode.Off:
			godot_shader_name = mtoon_shader_base_path + "_trans_cull_off"
	elif blend_mode == RenderMode.TransparentWithZWrite:
		godot_shader_name = mtoon_shader_base_path + "_trans_zwrite"
		if cull_mode == CullMode.Off:
			godot_shader_name = mtoon_shader_base_path + "_trans_zwrite_cull_off"

	var godot_shader: Shader = ResourceLoader.load(godot_shader_name + ".shader")
	var godot_shader_outline: Shader = null
	if godot_outline_shader_name:
		godot_shader_outline = ResourceLoader.load(godot_outline_shader_name + ".shader")

	var new_mat = ShaderMaterial.new()
	new_mat.resource_name = orig_mat.resource_name
	new_mat.shader = godot_shader
	if maintex_info.get("tex", null) != null:
		new_mat.set_shader_param("_MainTex", maintex_info["tex"])

	new_mat.set_shader_param("_MainTex_ST", Plane(
		maintex_info["scale"].x, maintex_info["scale"].y,
		maintex_info["offset"].x, maintex_info["offset"].y))

	for param_name in ["_MainTex", "_ShadeTexture", "_BumpMap", "_RimTexture", "_SphereAdd", "_EmissionMap", "_OutlineWidthTexture", "_UvAnimMaskTexture"]:
		var tex_info: Dictionary = _vrm_get_texture_info(gltf_images, vrm_mat_props, param_name)
		if tex_info.get("tex", null) != null:
			new_mat.set_shader_param(param_name, tex_info["tex"])

	for param_name in vrm_mat_props["floatProperties"]:
		new_mat.set_shader_param(param_name, vrm_mat_props["floatProperties"][param_name])
		
	for param_name in ["_Color", "_ShadeColor", "_RimColor", "_EmissionColor", "_OutlineColor"]:
		if param_name in vrm_mat_props["vectorProperties"]:
			var param_val = vrm_mat_props["vectorProperties"][param_name]
			var color_param: Color = Color(param_val[0], param_val[1], param_val[2], param_val[3])
			new_mat.set_shader_param(param_name, color_param)

	# FIXME: setting _Cutoff to disable cutoff is a bit unusual.
	if blend_mode == RenderMode.Cutout:
		new_mat.set_shader_param("_EnableAlphaCutout", 1.0)
	
	if godot_shader_outline != null:
		var outline_mat = new_mat.duplicate()
		outline_mat.shader = godot_shader_outline
		
		new_mat.next_pass = outline_mat
		
	# TODO: render queue -> new_mat.render_priority

	return new_mat


func _update_materials(vrm_extension: Dictionary, gstate: GLTFState):
	var images = gstate.get_images()
	print(images)
	var materials : Array = gstate.get_materials();
	var spatial_to_shader_mat : Dictionary = {}
	for i in range(materials.size()):
		var oldmat: Material = materials[i]
		if (oldmat is ShaderMaterial):
			print("Material " + str(i) + ": " + oldmat.resource_name + " already is shader.")
			continue
		var newmat: Material = _process_khr_material(oldmat, gstate.json["materials"][i])
		newmat = _process_vrm_material(newmat, images, vrm_extension["materialProperties"][i])
		spatial_to_shader_mat[oldmat] = newmat
		spatial_to_shader_mat[newmat] = newmat
		print("Replacing shader " + str(oldmat) + "/" + oldmat.resource_name + " with " + str(newmat) + "/" + newmat.resource_name)
		materials[i] = newmat
		var oldpath = oldmat.resource_path
		oldmat.resource_path = ""
		newmat.take_over_path(oldpath)
		ResourceSaver.save(oldpath, newmat)
	gstate.set_materials(materials)

	var meshes = gstate.get_meshes()
	for i in range(meshes.size()):
		var gltfmesh: GLTFMesh = meshes[i]
		var mesh: ArrayMesh = gltfmesh.mesh
		mesh.blend_shape_mode = ArrayMesh.BLEND_SHAPE_MODE_NORMALIZED
		for surf_idx in range(mesh.get_surface_count()):
			var surfmat = mesh.surface_get_material(surf_idx)
			if spatial_to_shader_mat.has(surfmat):
				mesh.surface_set_material(surf_idx, spatial_to_shader_mat[surfmat])
			else:
				printerr("Mesh " + str(i) + " material " + str(surf_idx) + " name " + surfmat.resource_name + " has no replacement material.")


func poolintarray_find(arr: PoolIntArray, val: int) -> int:
	for i in range(arr.size()):
		if arr[i] == val:
			return i
	return -1


func _get_skel_godot_node(gstate: GLTFState, nodes: Array, skeletons: Array, skel_id: int) -> Node:
	# There's no working direct way to convert from skeleton_id to node_id.
	# Bugs:
	# GLTFNode.parent is -1 if skeleton bone.
	# skeleton_to_node is empty
	# get_scene_node(skeleton bone) works though might maybe return an attachment.
	# var skel_node_idx = nodes[gltfskel.roots[0]]
	# return gstate.get_scene_node(skel_node_idx) # as Skeleton
	var gltfskel = skeletons[skel_id]
	for i in range(nodes.size()):
		if nodes[i].skeleton == skel_id:
			return gstate.get_scene_node(i)
	return null
	

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


func _create_meta(root_node: Node, animplayer: AnimationPlayer, vrm_extension: Dictionary, gstate: GLTFState, human_bone_to_idx: Dictionary) -> Dictionary:
	var nodes = gstate.get_nodes()
	var skeletons = gstate.get_skeletons()
	var hipsNode: GLTFNode = nodes[human_bone_to_idx["hips"]]
	var gltfskel: GLTFSkeleton = skeletons[hipsNode.skeleton]
	var skeleton: Skeleton = _get_skel_godot_node(gstate, nodes, skeletons, hipsNode.skeleton)
	var skeletonPath: NodePath = root_node.get_path_to(skeleton)

	var animPath: NodePath = root_node.get_path_to(animplayer)

	var firstperson = vrm_extension["firstPerson"]
	
	# FIXME: Technically this is supposed to be offset relative to the "firstPersonBone"
	# However, firstPersonBone defaults to Head...
	# and the semantics of a VR player having their viewpoint out of something which does
	# not rotate with their head is unclear.
	# Additionally, the spec schema says this:
	# "It is assumed that an offset from the head bone to the VR headset is added."
	# Which implies that the Head bone is used, not the firstPersonBone.
	var fpboneoffsetxyz = firstperson["firstPersonBoneOffset"] # example: 0,0.06,0
	var eyeOffset = Vector3(fpboneoffsetxyz["x"], fpboneoffsetxyz["y"], fpboneoffsetxyz["z"])
	# Assuming this position for now.
	# This data is not stored in any model metadata.
	# As an alternative, we could get the centroid of vertices moved by viseme blend shapes.
	# But for now, we'll assume this position:
	var mouthOffset = Vector3(fpboneoffsetxyz["x"], 0.0, fpboneoffsetxyz["z"])

	var humanBoneDictionary: Dictionary = {}
	for humanBoneName in human_bone_to_idx:
		humanBoneDictionary[humanBoneName] = poolintarray_find(gltfskel.joints, human_bone_to_idx[humanBoneName])

	var vrm_meta: Dictionary = {}
	
	vrm_meta["animplayer"] = animPath
	vrm_meta["skeleton"] = skeletonPath
	
	vrm_meta["exporterVersion"] = vrm_extension["exporterVersion"]
	vrm_meta["specVersion"] = vrm_extension["specVersion"]
	vrm_meta["title"] = vrm_extension["meta"]["title"]
	vrm_meta["version"] = vrm_extension["meta"]["version"]
	vrm_meta["author"] = vrm_extension["meta"]["author"]
	vrm_meta["contactInformation"] = vrm_extension["meta"]["contactInformation"]
	vrm_meta["reference"] = vrm_extension["meta"]["reference"]
	var tex: int = vrm_extension["meta"]["texture"]
	if tex >= 0:
		var gltftex: GLTFTexture = gstate.get_textures()[tex]
		vrm_meta["texture"] = gstate.get_images()[gltftex.src_image]
	vrm_meta["allowedUserName"] = vrm_extension["meta"]["allowedUserName"]
	vrm_meta["violentUsage"] = vrm_extension["meta"]["violentUssageName"]
	vrm_meta["sexualUsage"] = vrm_extension["meta"]["sexualUssageName"]
	vrm_meta["commercialUsage"] = vrm_extension["meta"]["commercialUssageName"]
	vrm_meta["otherPermissionUrl"] = vrm_extension["meta"]["otherPermissionUrl"]
	vrm_meta["licenseName"] = vrm_extension["meta"]["licenseName"]
	vrm_meta["otherLicenseUrl"] = vrm_extension["meta"]["otherLicenseUrl"]

	vrm_meta["eye_offset"] = eyeOffset
	vrm_meta["mouth_offset"] = mouthOffset
	vrm_meta["humanoid_bone_mapping"] = humanBoneDictionary
	return vrm_meta


func _create_animation_player(animplayer: AnimationPlayer, vrm_extension: Dictionary, gstate: GLTFState, human_bone_to_idx: Dictionary) -> AnimationPlayer:
	# Remove all glTF animation players for safety.
	# VRM does not support animation import in this way.
	for i in range(gstate.get_animation_players_count(0)):
		var node: AnimationPlayer = gstate.get_animation_player(i)
		node.get_parent().remove_child(node)

	var meshes = gstate.get_meshes()
	var nodes = gstate.get_nodes()
	var blend_shape_groups = vrm_extension["blendShapeMaster"]["blendShapeGroups"]
	# FIXME: Do we need to handle multiple references to the same mesh???
	var mesh_idx_to_meshinstance : Dictionary = {}
	var material_name_to_mesh_and_surface_idx: Dictionary = {}
	for i in range(meshes.size()):
		var gltfmesh : GLTFMesh = meshes[i]
		for j in range(gltfmesh.mesh.get_surface_count()):
			material_name_to_mesh_and_surface_idx[gltfmesh.mesh.surface_get_material(j).resource_name] = [i, j]
			
	for i in range(nodes.size()):
		var gltfnode: GLTFNode = nodes[i]
		var mesh_idx: int = gltfnode.mesh
		print("node idx " + str(i) + " node name " + gltfnode.resource_name + " mesh idx " + str(mesh_idx))
		if (mesh_idx != -1):
			var scenenode: MeshInstance = gstate.get_scene_node(i)
			mesh_idx_to_meshinstance[mesh_idx] = scenenode
			print("insert " + str(mesh_idx) + " node name " + scenenode.name)

	for shape in blend_shape_groups:
		print("Blend shape group: " + shape["name"])
		var anim = Animation.new()
		
		for matbind in shape["materialValues"]:
			var mesh_and_surface_idx = material_name_to_mesh_and_surface_idx[matbind["materialName"]]
			var node: MeshInstance = mesh_idx_to_meshinstance[mesh_and_surface_idx[0]]
			var surface_idx = mesh_and_surface_idx[1]

			var mat: Material = node.get_surface_material(surface_idx)
			var paramprop = "shader_param/" + matbind["parameterName"]
			var origvalue = null
			var tv = matbind["targetValue"]
			var newvalue = tv[0]
				
			if (mat is ShaderMaterial):
				var smat: ShaderMaterial = mat
				var param = smat.get_shader_param(matbind["parameterName"])
				if param is Color:
					origvalue = param
					newvalue = Color(tv[0], tv[1], tv[2], tv[3])
				elif matbind["parameterName"] == "_MainTex" or matbind["parameterName"] == "_MainTex_ST":
					origvalue = param
					newvalue = Plane(tv[2], tv[3], tv[0], tv[1]) if matbind["parameterName"] == "_MainTex" else Plane(tv[0], tv[1], tv[2], tv[3])
				elif param is float:
					origvalue = param
					newvalue = tv[0]
				else:
					printerr("Unknown type for parameter " + matbind["parameterName"] + " surface " + node.name + "/" + str(surface_idx))

			if origvalue != null:
				var animtrack: int = anim.add_track(Animation.TYPE_VALUE)
				anim.track_set_path(animtrack, str(animplayer.get_parent().get_path_to(node)) + ":mesh:surface_" + str(surface_idx) + "/material:" + paramprop)
				anim.track_set_interpolation_type(animtrack, Animation.INTERPOLATION_NEAREST if bool(shape["isBinary"]) else Animation.INTERPOLATION_LINEAR)
				anim.track_insert_key(animtrack, 0.0, origvalue)
				anim.track_insert_key(animtrack, 0.0, newvalue)
		for bind in shape["binds"]:
			# FIXME: Is this a mesh_idx or a node_idx???
			var node: MeshInstance = mesh_idx_to_meshinstance[int(bind["mesh"])]
			var nodeMesh: ArrayMesh = node.mesh;
			
			if (bind["index"] < 0 || bind["index"] >= nodeMesh.get_blend_shape_count()):
				printerr("Invalid blend shape index in bind " + str(shape) + " for mesh " + node.name)
				continue
			var animtrack: int = anim.add_track(Animation.TYPE_VALUE)
			nodeMesh.set_blend_shape_name(int(bind["index"]), shape["name"] + "_" + str(bind["index"]))
			anim.track_set_path(animtrack, str(animplayer.get_parent().get_path_to(node)) + ":blend_shapes/" + nodeMesh.get_blend_shape_name(int(bind["index"])))
			anim.track_set_interpolation_type(animtrack, Animation.INTERPOLATION_NEAREST if bool(shape["isBinary"]) else Animation.INTERPOLATION_LINEAR)
			anim.track_insert_key(animtrack, 0.0, float(0.0))
			# FIXME: Godot has weird normal/tangent singularities at weight=1.0 or weight=0.5
			# So we multiply by 0.99999 to produce roughly the same output, avoiding these singularities.
			anim.track_insert_key(animtrack, 1.0, 0.99999 * float(bind["weight"]) / 100.0)
			#var mesh:ArrayMesh = meshes[bind["mesh"]].mesh
			#print("Mesh name: " + mesh.resource_name)
			#print("Bind index: " + str(bind["index"]))
			#print("Bind weight: " + str(float(bind["weight"]) / 100.0))

		# https://github.com/vrm-c/vrm-specification/tree/master/specification/0.0#blendshape-name-identifier
		animplayer.add_animation(shape["name"].to_upper() if shape["presetName"] == "unknown" else shape["presetName"].to_upper(), anim)

	var firstperson = vrm_extension["firstPerson"]
	
	var firstpersanim: Animation = Animation.new()
	animplayer.add_animation("FirstPerson", firstpersanim)

	var thirdpersanim: Animation = Animation.new()
	animplayer.add_animation("ThirdPerson", thirdpersanim)

	var skeletons:Array = gstate.get_skeletons()

	var head_bone_idx = firstperson.get("firstPersonBone", -1)
	if (head_bone_idx >= 0):
		var headNode: GLTFNode = nodes[head_bone_idx]
		var gltfskel: GLTFSkeleton = skeletons[headNode.skeleton]
		var skeletonPath:NodePath = animplayer.get_parent().get_path_to(_get_skel_godot_node(gstate, nodes, skeletons, headNode.skeleton))
		var headBone: int = poolintarray_find(gltfskel.joints, head_bone_idx)
		var firstperstrack = firstpersanim.add_track(Animation.TYPE_METHOD)
		firstpersanim.track_set_path(firstperstrack, ".")
		firstpersanim.track_insert_key(firstperstrack, 0.0, {"method": "TODO_scale_bone", "args": [skeletonPath, headBone, 0.0]})
		var thirdperstrack = thirdpersanim.add_track(Animation.TYPE_METHOD)
		thirdpersanim.track_set_path(thirdperstrack, ".")
		thirdpersanim.track_insert_key(thirdperstrack, 0.0, {"method": "TODO_scale_bone", "args": [skeletonPath, headBone, 1.0]})

	for meshannotation in firstperson["meshAnnotations"]:

		var flag = FirstPersonParser.get(meshannotation["firstPersonFlag"], -1)
		var first_person_visibility;
		var third_person_visibility;
		if flag == FirstPersonFlag.ThirdPersonOnly:
			first_person_visibility = 0.0
			third_person_visibility = 1.0
		elif flag == FirstPersonFlag.FirstPersonOnly:
			first_person_visibility = 1.0
			third_person_visibility = 0.0
		else:
			continue
		var node: MeshInstance = mesh_idx_to_meshinstance[int(meshannotation["mesh"])]
		var firstperstrack = firstpersanim.add_track(Animation.TYPE_VALUE)
		firstpersanim.track_set_path(firstperstrack, str(animplayer.get_parent().get_path_to(node)) + ":visible")
		firstpersanim.track_insert_key(firstperstrack, 0.0, first_person_visibility)
		var thirdperstrack = thirdpersanim.add_track(Animation.TYPE_VALUE)
		thirdpersanim.track_set_path(thirdperstrack, str(animplayer.get_parent().get_path_to(node)) + ":visible")
		thirdpersanim.track_insert_key(thirdperstrack, 0.0, third_person_visibility)

	if firstperson.get("lookAtTypeName", "") == "Bone":
		var horizout = firstperson["lookAtHorizontalOuter"]
		var horizin = firstperson["lookAtHorizontalInner"]
		var vertup = firstperson["lookAtVerticalUp"]
		var vertdown = firstperson["lookAtVerticalDown"]
		var leftEyeNode: GLTFNode = nodes[human_bone_to_idx["leftEye"]]
		var gltfskel: GLTFSkeleton = skeletons[leftEyeNode.skeleton]
		var skeleton:Skeleton = _get_skel_godot_node(gstate, nodes, skeletons,leftEyeNode.skeleton)
		var skeletonPath:NodePath = animplayer.get_parent().get_path_to(skeleton)
		var leftEyeBone: int = poolintarray_find(gltfskel.joints, human_bone_to_idx["leftEye"])
		var leftEyePath = str(skeletonPath) + ":" + skeleton.get_bone_name(leftEyeBone)
		var rightEyeNode: GLTFNode = nodes[human_bone_to_idx["rightEye"]]
		gltfskel = skeletons[rightEyeNode.skeleton]
		skeleton = _get_skel_godot_node(gstate, nodes, skeletons,rightEyeNode.skeleton)
		skeletonPath = animplayer.get_parent().get_path_to(skeleton)
		var rightEyeBone: int = poolintarray_find(gltfskel.joints, human_bone_to_idx["rightEye"])
		var rightEyePath = str(skeletonPath) + ":" + skeleton.get_bone_name(rightEyeBone)

		var anim = animplayer.get_animation("LOOKLEFT")
		var animtrack = anim.add_track(Animation.TYPE_TRANSFORM)
		anim.track_set_path(animtrack, leftEyePath)
		anim.track_set_interpolation_type(animtrack, Animation.INTERPOLATION_LINEAR)
		anim.transform_track_insert_key(animtrack, 0.0, Vector3.ZERO, Quat.IDENTITY, Vector3.ONE)
		anim.transform_track_insert_key(animtrack, horizout["xRange"] / 90.0, Vector3.ZERO, Basis(Vector3(0,1,0), horizout["yRange"] * 3.14159/180.0).get_rotation_quat(), Vector3.ONE)
		animtrack = anim.add_track(Animation.TYPE_TRANSFORM)
		anim.track_set_path(animtrack, rightEyePath)
		anim.track_set_interpolation_type(animtrack, Animation.INTERPOLATION_LINEAR)
		anim.transform_track_insert_key(animtrack, 0.0, Vector3.ZERO, Quat.IDENTITY, Vector3.ONE)
		anim.transform_track_insert_key(animtrack, horizin["xRange"] / 90.0, Vector3.ZERO, Basis(Vector3(0,1,0), horizin["yRange"] * 3.14159/180.0).get_rotation_quat(), Vector3.ONE)

		anim = animplayer.get_animation("LOOKRIGHT")
		animtrack = anim.add_track(Animation.TYPE_TRANSFORM)
		anim.track_set_path(animtrack, leftEyePath)
		anim.track_set_interpolation_type(animtrack, Animation.INTERPOLATION_LINEAR)
		anim.transform_track_insert_key(animtrack, 0.0, Vector3.ZERO, Quat.IDENTITY, Vector3.ONE)
		anim.transform_track_insert_key(animtrack, horizin["xRange"] / 90.0, Vector3.ZERO, Basis(Vector3(0,1,0), -horizin["yRange"] * 3.14159/180.0).get_rotation_quat(), Vector3.ONE)
		animtrack = anim.add_track(Animation.TYPE_TRANSFORM)
		anim.track_set_path(animtrack, rightEyePath)
		anim.track_set_interpolation_type(animtrack, Animation.INTERPOLATION_LINEAR)
		anim.transform_track_insert_key(animtrack, 0.0, Vector3.ZERO, Quat.IDENTITY, Vector3.ONE)
		anim.transform_track_insert_key(animtrack, horizout["xRange"] / 90.0, Vector3.ZERO, Basis(Vector3(0,1,0), -horizout["yRange"] * 3.14159/180.0).get_rotation_quat(), Vector3.ONE)

		anim = animplayer.get_animation("LOOKUP")
		animtrack = anim.add_track(Animation.TYPE_TRANSFORM)
		anim.track_set_path(animtrack, leftEyePath)
		anim.track_set_interpolation_type(animtrack, Animation.INTERPOLATION_LINEAR)
		anim.transform_track_insert_key(animtrack, 0.0, Vector3.ZERO, Quat.IDENTITY, Vector3.ONE)
		anim.transform_track_insert_key(animtrack, vertup["xRange"] / 90.0, Vector3.ZERO, Basis(Vector3(1,0,0), vertup["yRange"] * 3.14159/180.0).get_rotation_quat(), Vector3.ONE)
		animtrack = anim.add_track(Animation.TYPE_TRANSFORM)
		anim.track_set_path(animtrack, rightEyePath)
		anim.track_set_interpolation_type(animtrack, Animation.INTERPOLATION_LINEAR)
		anim.transform_track_insert_key(animtrack, 0.0, Vector3.ZERO, Quat.IDENTITY, Vector3.ONE)
		anim.transform_track_insert_key(animtrack, vertup["xRange"] / 90.0, Vector3.ZERO, Basis(Vector3(1,0,0), vertup["yRange"] * 3.14159/180.0).get_rotation_quat(), Vector3.ONE)

		anim = animplayer.get_animation("LOOKDOWN")
		animtrack = anim.add_track(Animation.TYPE_TRANSFORM)
		anim.track_set_path(animtrack, leftEyePath)
		anim.track_set_interpolation_type(animtrack, Animation.INTERPOLATION_LINEAR)
		anim.transform_track_insert_key(animtrack, 0.0, Vector3.ZERO, Quat.IDENTITY, Vector3.ONE)
		anim.transform_track_insert_key(animtrack, vertdown["xRange"] / 90.0, Vector3.ZERO, Basis(Vector3(1,0,0), -vertdown["yRange"] * 3.14159/180.0).get_rotation_quat(), Vector3.ONE)
		animtrack = anim.add_track(Animation.TYPE_TRANSFORM)
		anim.track_set_path(animtrack, rightEyePath)
		anim.track_set_interpolation_type(animtrack, Animation.INTERPOLATION_LINEAR)
		anim.transform_track_insert_key(animtrack, 0.0, Vector3.ZERO, Quat.IDENTITY, Vector3.ONE)
		anim.transform_track_insert_key(animtrack, vertdown["xRange"] / 90.0, Vector3.ZERO, Basis(Vector3(1,0,0), -vertdown["yRange"] * 3.14159/180.0).get_rotation_quat(), Vector3.ONE)

	return animplayer

func _import_scene(path: String, flags: int, bake_fps: int):
	var f = File.new()
	if f.open(path, File.READ) != OK:
		return FAILED

	var magic = f.get_32()
	if magic != 0x46546C67:
		return ERR_FILE_UNRECOGNIZED
	f.get_32() # version
	f.get_32() # length

	var chunk_length = f.get_32();
	var chunk_type = f.get_32();

	if chunk_type != 0x4E4F534A:
		return ERR_PARSE_ERROR
	var json_data : PoolByteArray = f.get_buffer(chunk_length)
	f.close()

	var text : String = json_data.get_string_from_utf8()
	read_vrm(text)
	var gstate : GLTFState = GLTFState.new()
	var gltf : PackedSceneGLTF = PackedSceneGLTF.new()
	print(path);
	var root_node : Node = gltf.import_gltf_scene(path, 0, 1000.0, gstate)

	var gltf_json : Dictionary = gstate.json
	var vrm_extension : Dictionary = gltf_json["extensions"]["VRM"]

	var human_bone_to_idx: Dictionary = {}
	# Ignoring in ["humanoid"]: armStretch, legStretch, upperArmTwist
	# lowerArmTwist, upperLegTwist, lowerLegTwist, feetSpacing,
	# and hasTranslationDoF
	for human_bone in vrm_extension["humanoid"]["humanBones"]:
		human_bone_to_idx[human_bone["bone"]] = int(human_bone["node"])
		# Unity Mecanim properties:
		# Ignoring: useDefaultValues
		# Ignoring: min
		# Ignoring: max
		# Ignoring: center
		# Ingoring: axisLength

	_update_materials(vrm_extension, gstate)

	var animplayer = AnimationPlayer.new()
	animplayer.name = "anim"
	root_node.add_child(animplayer)
	animplayer.owner = root_node
	_create_animation_player(animplayer, vrm_extension, gstate, human_bone_to_idx)

	var vrmmeta = _create_meta(root_node, animplayer, vrm_extension, gstate, human_bone_to_idx)

	if (!ResourceLoader.exists(path + ".res")):
		ResourceSaver.save(path + ".res", gstate)
	root_node.set_meta("VRMMeta", vrmmeta)
	return root_node


func import_animation_from_other_importer(path: String, flags: int, bake_fps: int):
	return self._import_animation(path, flags, bake_fps)


func import_scene_from_other_importer(path: String, flags: int, bake_fps: int):
	return self._import_scene(path, flags, bake_fps)

func _convert_sql_to_material_param(column_name: String, value):
	if "color" in column_name:
		pass
	return value

func _to_dict(columns: Array, values: Array):
	var dict : Dictionary = {}
	for i in range(columns.size()):
		dict[columns[i]] = values[i]
	return dict

func _to_material_param_dict(columns: Array, values: Array):
	var dict : Dictionary = {}
	print("Col size=" + str(columns.size()) + " val size=" + str(values.size()))
	for i in range(min(columns.size(), values.size())):
		dict[columns[i]] = _convert_sql_to_material_param(columns[i], values[i])
	return dict

func read_vrm(json: String):
		# Create gdsqlite instance
	var db : SQLite = SQLite.new();
	
	# Open database
	if (!db.open_in_memory()):
		return;
	
	var query = "";
	var result = null;
		
	query = "CREATE TABLE vrm(id INTEGER, vrm JSON);";
	db.query(query);
		
	db.query_with_args("INSERT INTO vrm(id, vrm) values (1, json(?));", [json])
	
	query = """
	CREATE VIEW vrm_bone AS WITH human_bones AS (
	SELECT value FROM vrm,
	json_each(json_extract(\"vrm\", '$.extensions.VRM.humanoid.humanBones'))) SELECT
	json_extract(value, '$.bone') as name, json_extract(value, '$.node')
	AS node FROM human_bones;)
	"""
	db.query(query)

	query = "CREATE VIEW vrm_def AS SELECT key, value"
	query += " FROM vrm, json_each(json_extract(\"vrm\", '$.extensions.VRM'));"
	db.query(query)
#
	#  https://modern-sql.com/feature/filter
	query = """
		CREATE VIEW vrm_meta AS SELECT
		MAX(meta.value) FILTER (WHERE meta.key = 'title') as title,
		MAX(meta.value) FILTER (WHERE meta.key = 'version') as version,
		MAX(meta.value) FILTER (WHERE meta.key = 'author') as author,
		MAX(meta.value) FILTER (WHERE meta.key = 'contactInformation') as contact_information,
		MAX(meta.value) FILTER (WHERE meta.key = 'reference') as reference,
		MAX(meta.value) FILTER (WHERE meta.key = 'texture') as texture,
		MAX(meta.value) FILTER (WHERE meta.key = 'allowedUserName') as allowed_user_name,
		MAX(meta.value) FILTER (WHERE meta.key = 'violentUssageName') as violent_usage_name,
		MAX(meta.value) FILTER (WHERE meta.key = 'sexualUssageName') as sexual_usage_name,
		MAX(meta.value) FILTER (WHERE meta.key = 'commercialUssageName') as commercial_usage_name,
		MAX(meta.value) FILTER (WHERE meta.key = 'otherPermissionUrl') as other_permission_url,
		MAX(meta.value) FILTER (WHERE meta.key = 'licenseName') as license_name,
		MAX(meta.value) FILTER (WHERE meta.key = 'otherLicenseUrl') as other_license_url
		FROM vrm, json_each(json_extract(\"vrm\", '$.extensions.VRM.meta')) as meta;
		"""
	db.query(query)

	db.query("""
	CREATE VIEW vrm_material AS WITH float_properties AS (WITH material_properties AS (
	SELECT
		key, value
	FROM
		vrm, json_each(json_extract("vrm", '$.extensions.VRM.materialProperties')))
	SELECT
		json_extract(material_properties.value, '$.name') as name,
		json_extract(material_properties.value, '$.shader') as shader,
		json_extract(material_properties.value, '$.renderQueue') as render_queue,
		json_extract(material_properties.value, '$.floatProperties') as float_properties,
		json_extract(material_properties.value, '$.vectorProperties') as vector_properties,
		json_extract(material_properties.value, '$.textureProperties') as texture_properties,
		json_extract(material_properties.value, '$.keywordMap') as keyword_map
	FROM
		material_properties)
	SELECT
		name,
		shader,
		render_queue,
		keyword_map,
		-- https://modern-sql.com/feature/filter
		MAX(fp.value) FILTER (
		WHERE fp.key = '_Cutoff') as cutoff,
		MAX(fp.value) FILTER (
		WHERE fp.key = '_BumpScale') as bump_scale,
		MAX(fp.value) FILTER (
		WHERE fp.key = '_ReceiveShadowRate') as recieve_shadow_rate,
		MAX(fp.value) FILTER (
		WHERE fp.key = '_ShadingGradeRate') as shading_grade_rate,
		MAX(fp.value) FILTER (
		WHERE fp.key = '_ShadeShift') as shade_shift,
		MAX(fp.value) FILTER (
		WHERE fp.key = '_ShadeToony') as shade_toony,
		MAX(fp.value) FILTER (
		WHERE fp.key = '_LightColorAttenuation') as light_color_attenuation,
		MAX(fp.value) FILTER (
		WHERE fp.key = '_IndirectLightIntensity') as indirect_light_intensity,
		MAX(fp.value) FILTER (
		WHERE fp.key = '_OutlineWidth') as outline_width,
		MAX(fp.value) FILTER (
		WHERE fp.key = '_OutlineScaledMaxDistance') as outline_scaled_max_distance,
		MAX(fp.value) FILTER (
		WHERE fp.key = '_OutlineLightingMix') as outline_lighting_mix,
		MAX(fp.value) FILTER (
		WHERE fp.key = '_DebugMode') as debug_mode,
		MAX(fp.value) FILTER (
		WHERE fp.key = '_BlendMode') as blend_mode,
		MAX(fp.value) FILTER (
		WHERE fp.key = '_OutlineWidthMode') as outline_width_mode,
		MAX(fp.value) FILTER (
		WHERE fp.key = '_OutlineColorMode') as outline_color_mode,
		MAX(fp.value) FILTER (
		WHERE fp.key = '_CullMode') as cull_mode,
		MAX(fp.value) FILTER (
		WHERE fp.key = '_SrcBlend') as src_blend,
		MAX(fp.value) FILTER (
		WHERE fp.key = '_DstBlend') as dst_blend,
		MAX(fp.value) FILTER (
		WHERE fp.key = '_ZWrite') as z_write,
		MAX(vp.value) FILTER (
		WHERE vp.key = '_Color') as color,
		MAX(vp.value) FILTER (
		WHERE vp.key = '_ShadeColor') as shade_color,
		MAX(tp.value) FILTER (
		WHERE tp.key = '_BumpMap') as bump_map,
		MAX(tp.value) FILTER (
		WHERE tp.key = '_ReceiveShadowTexture') as receive_shadow_texture,
		MAX(tp.value) FILTER (
		WHERE tp.key = '_ShadingGradeTexture') as shading_grade_texture,
		MAX(vp.value) FILTER (
		WHERE vp.key = '_SphereAdd') as sphere_add,
		MAX(vp.value) FILTER (
		WHERE vp.key = '_EmissionColor') as emission_color,
		MAX(tp.value) FILTER (
		WHERE tp.key = '_EmissionMap') as emission_map,
		MAX(vp.value) FILTER (
		WHERE vp.key = '_OutlineWidthTexture') as outline_width_texture,
		MAX(vp.value) FILTER (
		WHERE vp.key = '_OutlineColor') as outline_color,
		MAX(tp.value) FILTER (
		WHERE tp.key = '_MainTex') as main_tex,
		MAX(tp.value) FILTER (
		WHERE tp.key = '_ShadeTexture') as shade_texture,
		MAX(tp.value) FILTER (
		WHERE tp.key = '_SphereAdd') as sphere_add
	FROM
		float_properties,
		json_each(float_properties) as fp,
		json_each(vector_properties) as vp ,
		json_each(texture_properties) as tp,
		json_each(keyword_map) as km
	GROUP BY
		name;
	""")
	
#	var vrm_data : SQLiteQuery = db.create_query("SELECT * FROM vrm_material")
#	var columns: Array = vrm_data.get_columns()
#	var list_of_materials: Array = vrm_data.execute()

	#for material in list_of_materials:
	#	var param_dict = _to_material_param_dict(columns, material)
	#	#print(param_dict)
	
	#var dict = make_dict(
	#print(vrm_data.get_columns())
	#print()
	
	#vrm_data = db.create_query("SELECT * FROM vrm_meta")
	#print(vrm_data.get_columns())
	#print(vrm_data.execute())
	
	#vrm_data = db.create_query("SELECT * FROM vrm_bone LIMIT 1")
	#print(vrm_data.get_columns())
	#print(vrm_data.execute())
	
	# Close database
	db.close();
	
	





