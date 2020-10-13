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

	if (!ResourceLoader.exists(path + ".res")):
		ResourceSaver.save(path + ".res", gstate)

	var images = gstate.get_images()
	print(images)
	var meshes = gstate.get_meshes()

	var materials : Array = gstate.get_materials();

	var gltf_json : Dictionary = gstate.json
	var vrm_extension : Dictionary = gltf_json["extensions"]["VRM"]
	
	var spatial_to_shader_mat : Dictionary = {}
	for i in range(materials.size()):
		var oldmat: Material = materials[i]
		if (oldmat is ShaderMaterial):
			print("Material " + str(i) + ": " + oldmat.resource_name + " already is shader.")
			continue
		var newmat: Material = _process_khr_material(oldmat, gltf_json["materials"][i])
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
	var blend_shape_groups = vrm_extension["blendShapeMaster"]["blendShapeGroups"]
	for shape in blend_shape_groups:
		print("Blend shape group: " + shape["name"])
		if !shape["binds"].size():
			continue
		for bind in shape["binds"]:
			var mesh:ArrayMesh = meshes[bind["mesh"]].mesh
			print("Mesh name: " + mesh.resource_name)
			print("Bind index: " + str(bind["index"]))
			print("Bind weight: " + str(float(bind["weight"]) / 100.0))
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

	#var nodes = gstate.get_nodes()

	gltf.pack(root_node)
	return gltf.instance()

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
	
	





