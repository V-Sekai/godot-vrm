extends GLTFDocumentExtension

enum DebugMode {
	None = 0,
	Normal = 1,
	LitShadeRate = 2,
}

enum OutlineColorMode {
	FixedColor = 0,
	MixedLight3Ding = 1,
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

func _import_preflight(state: GLTFState, extensions = PackedStringArray()) -> Error:
	if extensions.has("VRMC_materials_mtoon"):
		return OK
	return ERR_INVALID_DATA




func _vrm_get_texture_info(gltf_images: Array, vrm_mat_props: Dictionary, unity_tex_name: String) -> Dictionary:
	var texture_info: Dictionary = {}
	texture_info["tex"] = null
	texture_info["offset"] = Vector3(0.0, 0.0, 0.0)
	texture_info["scale"] = Vector3(1.0, 1.0, 1.0)
	if vrm_mat_props["textureProperties"].has(unity_tex_name):
		var mainTexId: int = vrm_mat_props["textureProperties"][unity_tex_name]
		var mainTexImage: Texture2D = gltf_images[mainTexId]
		texture_info["tex"] = mainTexImage
	if vrm_mat_props["vectorProperties"].has(unity_tex_name):
		var offsetScale: Array = vrm_mat_props["vectorProperties"][unity_tex_name]
		texture_info["offset"] = Vector3(offsetScale[0], offsetScale[1], 0.0)
		texture_info["scale"] = Vector3(offsetScale[2], offsetScale[3], 1.0)
	return texture_info


func _vrm_get_float(vrm_mat_props: Dictionary, key: String, def: float) -> float:
	return vrm_mat_props["floatProperties"].get(key, def)


func _assign_property(new_mat: ShaderMaterial, property_name: String, property_value: Variant) -> void:
	new_mat.set_shader_parameter(property_name, property_value)
	if new_mat.next_pass != null:
		new_mat.next_pass.set_shader_parameter(property_name, property_value)

func _assign_texture(new_mat: ShaderMaterial, gltf_images: Array, texture_name: String, texture_info: Dictionary) -> void:
	# TODO: something with texCoord
	# TODO: something with extensions[KHR_texture_transform].texCoord
	# TODO: something with extensions[KHR_texture_transform].offset/scale?
	var tex: Texture2D = null
	if texture_info.has("index"):
		tex = gltf_images[texture_info["index"]]

	_assign_property(new_mat, texture_name, tex)

func _assign_color(new_mat: ShaderMaterial, has_alpha: bool, property_name: String, color_array: Array) -> void:
	var col: Color
	if has_alpha:
		col = Color(color_array[0], color_array[1], color_array[2], color_array[3])
	else:
		col = Color(color_array[0], color_array[1], color_array[2])

	_assign_property(new_mat, property_name, col)

func _process_vrm_material(orig_mat: Material, gltf_images: Array, mat_props: Dictionary, vrm_mat_props: Dictionary) -> Material:

	if vrm_mat_props.get("specVersion", "") != "1.0":
		push_warning("Unsupported VRM MToon specVersion " + str(vrm_mat_props.get("specVersion", "")))

	var blend_extension: String = ""
	var alpha_mode: String = mat_props.get("alphaMode", "OPAQUE")
	if alpha_mode == "MASK":
		blend_extension = "_cutout"
	if alpha_mode == "BLEND":
		blend_extension = "_trans"
		if vrm_mat_props.get("transparentWithZWrite", false) == true:
			blend_extension += "_zwrite"

	var outline_width_mode: String = vrm_mat_props.get("outlineWidthMode", "none")

	var mtoon_shader_base_path: String = "res://addons/Godot-MToon-Shader/mtoon"

	var godot_outline_shader_name: String = ""
	if outline_width_mode != "none":
		godot_outline_shader_name = mtoon_shader_base_path + "_outline" + blend_extension

	var godot_shader_name = mtoon_shader_base_path + blend_extension
	if mat_props.get("doubleSided", false) == true:
		godot_shader_name += "_cull_off"

	var godot_shader: Shader = ResourceLoader.load(godot_shader_name + ".gdshader")

	var new_mat : ShaderMaterial = ShaderMaterial.new()
	new_mat.resource_name = orig_mat.resource_name
	new_mat.shader = godot_shader

	var godot_shader_outline: Shader = null
	if !godot_outline_shader_name.is_empty():
		godot_shader_outline = ResourceLoader.load(godot_outline_shader_name + ".gdshader")

	var outline_mat: ShaderMaterial = null
	if godot_shader_outline != null:
		outline_mat = ShaderMaterial.new()
		outline_mat.resource_name = orig_mat.resource_name + "(Outline)"
		outline_mat.shader = godot_shader_outline
		new_mat.next_pass = outline_mat

	var base_color_texture = mat_props.get("pbrMetallicRoughness", {}).get("baseColorTexture", {})
	var khr_texture_transform = base_color_texture.get("extensions", {}).get("KHR_texture_transform", {})
	var offset = khr_texture_transform.get("offset", [0.0, 0.0])
	var scale = khr_texture_transform.get("scale", [1.0, 1.0])
	# texCoord does not seem implemented in MToon.
	# KHR_texture_transform also has its own texCoord.
	# KHR_texture_transform is only supported by `baseColorTexture`
	var texture_repeat = Vector4(scale[0], scale[1], offset[0], offset[1])

	_assign_texture(new_mat, gltf_images, "_MainTex", base_color_texture)
	_assign_texture(new_mat, gltf_images, "_ShadeTexture", vrm_mat_props.get("shadeMultiplyTexture", {}))
	_assign_texture(new_mat, gltf_images, "_ShadeToonyMultiplyTexture", vrm_mat_props.get("shadeMultiplyTexture", {}))
	_assign_texture(new_mat, gltf_images, "_BumpMap", mat_props.get("normalTexture", {}))
	_assign_texture(new_mat, gltf_images, "_EmissionMap", mat_props.get("emissiveTexture", {}))
	# TODO: implement emission factor?
	# var vrmc_emissive: Dictionary = mat_props.get("extensions", {}).get("VRMC_materials_hdr_emissiveMultiplier", {})
	# var khr_emissive: Dictionary = mat_props.get("extensions", {}).get("KHR_materials_emissive_strength", {})

	_assign_texture(new_mat, gltf_images, "_RimTexture", vrm_mat_props.get("rimMultiplyTexture", {}))
	_assign_texture(new_mat, gltf_images, "_SphereAdd", vrm_mat_props.get("matcapTexture", {}))
	_assign_texture(new_mat, gltf_images, "_UvAnimMaskTexture", vrm_mat_props.get("uvAnimationMaskTexture", {}))
	_assign_texture(new_mat, gltf_images, "_OutlineWidthTexture", vrm_mat_props.get("outlineWidthMultiplyTexture", {}))

	_assign_color(new_mat, true, "_Color", mat_props.get("pbrMetallicRoughness", {}).get("baseColorFactor", [1,1,1,1]))
	_assign_color(new_mat, false, "_ShadeColor", vrm_mat_props.get("shadeColorFactor", [0,0,0]))
	_assign_color(new_mat, false, "_RimColor", vrm_mat_props.get("parametricRimColorFactor", [0,0,0]))
	# FIXME: _MatcapColor does not exist!!
	_assign_color(new_mat, false, "_MatcapColor", vrm_mat_props.get("matcapFactor", [1,1,1]))
	_assign_color(new_mat, false, "_OutlineColor", vrm_mat_props.get("outlineColorFactor", [0,0,0,1]))
	_assign_color(new_mat, false, "_EmissionColor", mat_props.get("emissiveFactor", [0,0,0]))

	_assign_property(new_mat, "_MainTex_ST", texture_repeat)

	var outline_width_idx: float = 0
	if outline_width_mode == "worldCoordinates":
		outline_width_idx = 1
	if outline_width_mode == "screenCoordinates":
		outline_width_idx = 2
	_assign_property(new_mat, "_OutlineWidthMode", outline_width_idx)

	#"_ReceiveShadowRate": ["Shadow Receive", "Texture (R) * Rate. White is Default. Black attenuates shadows."],
	#"_LightColorAttenuation": ["Light Color Atten", "Light Color Attenuation"],
	#"_IndirectLightIntensity": ["GI Intensity", "Indirect Light Intensity"],
	#"_OutlineScaledMaxDistance": ["Outline Scaled Dist", "Width Scaled Max Distance"],

	_assign_property(new_mat, "_AlphaCutoutEnable", 1.0 if alpha_mode == "MASK" else 0.0)
	_assign_property(new_mat, "_BumpScale", mat_props.get("normalTexture", {}).get("scale", 1.0))
	_assign_property(new_mat, "_Cutoff", mat_props.get("alphaCutoff", 0.5))
	_assign_property(new_mat, "_ShadeToony", vrm_mat_props.get("shadingToonyFactor", 0.9))
	_assign_property(new_mat, "_ShadeShift", vrm_mat_props.get("shadingShiftFactor", 0.0))
	_assign_property(new_mat, "_ShadingGradeRate", vrm_mat_props.get("shadeMultiplyTexture", {}).get("scale", 1.0))
	_assign_property(new_mat, "_ReceiveShadowRate", 1.0) # 0 disables directional light shadows. no longer supported?
	_assign_property(new_mat, "_LightColorAttenuation", 0.0) # not useful
	_assign_property(new_mat, "_IndirectLightIntensity", 1.0 - vrm_mat_props.get("giEqualizationFactor", 0.9))
	_assign_property(new_mat, "_OutlineScaledMaxDistance", 99.0) # FIXME: different calulcation
	_assign_property(new_mat, "_RimLightingMix", vrm_mat_props.get("rimLightingMixFactor", 0.0))
	_assign_property(new_mat, "_RimFresnelPower", vrm_mat_props.get("parametricRimFresnelPowerFactor", 1.0))
	_assign_property(new_mat, "_RimLift", vrm_mat_props.get("parametricRimLiftFactor", 0.0))
	_assign_property(new_mat, "_OutlineWidth", vrm_mat_props.get("outlineWidthFactor", 0.0))
	_assign_property(new_mat, "_OutlineColorMode", 1.0) # MixedLighting always. FixedColor if outlineLightingMixFactor==0
	_assign_property(new_mat, "_OutlineLightingMix", vrm_mat_props.get("outlineLightingMixFactor", 1.0))
	_assign_property(new_mat, "_UvAnimScrollX", vrm_mat_props.get("uvAnimationScrollXSpeedFactor", 0.0))
	_assign_property(new_mat, "_UvAnimScrollY", vrm_mat_props.get("uvAnimationScrollYSpeedFactor", 0.0))
	_assign_property(new_mat, "_UvAnimRotation", vrm_mat_props.get("uvAnimationRotationSpeedFactor", 0.0))

	if alpha_mode == "BLEND":
		var delta_render_queue = vrm_mat_props.get("renderQueueOffsetNumbers", 0)
		if vrm_mat_props.get("transparentWithZWrite", false) == true:
			# renderQueueOffsetNumbers range for this case is 0 to +9
			# must be rendered before transparentWithZWrite==false
			# transparentWithZWrite==false has renderQueueOffsetNumbers between -9 and 0
			# so we need these to be below that.
			delta_render_queue -= 19
		# render_priority only makes sense for transparent materials.
		new_mat.render_priority = delta_render_queue
		if outline_mat != null:
			outline_mat.render_priority = delta_render_queue
	else:
		new_mat.render_priority = 0
		if outline_mat != null:
			outline_mat.render_priority = 0
		
	return new_mat


# Called when the node enters the scene tree for the first time.
func _import_post(gstate, root):
	var images = gstate.get_images()
	#print(images)
	var materials: Array = gstate.get_materials()
	var materials_json: Array[Dictionary] = []
	var materials_vrm_json: Array[Dictionary] = []
	var spatial_to_shader_mat: Dictionary = {}

	for i in range(materials.size()):
		var material: Material = materials[i]
		var json_material = gstate.json["materials"][i]
		materials_json.push_back(json_material)
		var extensions: Dictionary = json_material.get("extensions", {})
		materials_vrm_json.push_back(extensions.get("VRMC_materials_mtoon", {}))
		
	# Material conversions
	for i in range(materials.size()):
		var oldmat: Material = materials[i]
		if oldmat is ShaderMaterial:
			# Indicates that the user asked to keep existing materials. Avoid changing them.
			print("Material " + str(i) + ": " + str(oldmat.resource_name) + " already is shader.")
			continue
		var newmat: Material = oldmat
		var mat_props: Dictionary = materials_json[i]
		var vrm_mat_props: Dictionary = materials_vrm_json[i]
		newmat = _process_vrm_material(newmat, images, mat_props, vrm_mat_props)
		spatial_to_shader_mat[oldmat] = newmat
		spatial_to_shader_mat[newmat] = newmat
		# print("Replacing shader " + str(oldmat) + "/" + str(oldmat.resource_name) + " with " + str(newmat) + "/" + str(newmat.resource_name))
		materials[i] = newmat
		var oldpath = oldmat.resource_path
		if oldpath.is_empty():
			continue
		newmat.take_over_path(oldpath)
		ResourceSaver.save(newmat, oldpath)
	gstate.set_materials(materials)

	var meshes = gstate.get_meshes()
	for i in range(meshes.size()):
		var gltfmesh: GLTFMesh = meshes[i]
		var mesh = gltfmesh.mesh
		mesh.set_blend_shape_mode(Mesh.BLEND_SHAPE_MODE_NORMALIZED)
		for surf_idx in range(mesh.get_surface_count()):
			var surfmat = mesh.get_surface_material(surf_idx)
			if spatial_to_shader_mat.has(surfmat):
				mesh.set_surface_material(surf_idx, spatial_to_shader_mat[surfmat])
			else:
				printerr("Mesh " + str(i) + " material " + str(surf_idx) + " name " + str(surfmat.resource_name) + " has no replacement material.")

	# FIXME: due to head duplication, do we now have some meshes which are not in gltf state?
