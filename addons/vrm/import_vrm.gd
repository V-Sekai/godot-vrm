tool
extends EditorSceneImporter


func _get_extensions():
	return ["vrm"]


func _get_import_flags():
	return EditorSceneImporter.IMPORT_SCENE


func _import_animation(path: String, flags: int, bake_fps: int):
	return Animation.new()


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
	var gltf = PackedSceneGLTF.new()
	gltf.pack_gltf(path, 0, 1000.0)
	return gltf.instance()


func import_animation_from_other_importer(path: String, flags: int, bake_fps: int):
	return self._import_animation(path, flags, bake_fps)


func import_scene_from_other_importer(path: String, flags: int, bake_fps: int):
	return self._import_scene(path, flags, bake_fps)

func read_vrm(json: String):
		# Create gdsqlite instance
	var db : SQLite = SQLite.new();
	
	# Open database
	if (!db.open_in_memory()):
		return;
	
	var query = "";
	var result = null;
	
	db.query("DROP TABLE IF EXISTS vrm;")
	
	query = "CREATE TABLE vrm(id INTEGER, vrm JSON);";
	db.query(query);
		
	db.query_with_args("INSERT INTO vrm(id, vrm) values (1, json(?));", [json])	
	
	db.query("DROP VIEW IF EXISTS vrm_bone;")
	query = """
	CREATE VIEW vrm_bone AS WITH human_bones AS (
	SELECT value FROM vrm,
	json_each(json_extract(\"vrm\", '$.extensions.VRM.humanoid.humanBones'))) SELECT
	json_extract(value, '$.bone') as name, json_extract(value, '$.node')
	AS node FROM human_bones;)
	"""
	db.query(query)

	db.query("DROP VIEW IF EXISTS vrm_def;")
	
	query = "CREATE VIEW vrm_def AS SELECT key, value"
	query += " FROM vrm, json_each(json_extract(\"vrm\", '$.extensions.VRM'));"
	db.query(query)
#
	db.query("DROP VIEW IF EXISTS vrm_meta;")
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

	db.query("""DROP VIEW IF EXISTS vrm_material;""")

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
		MAX(vp.value) FILTER (
		WHERE vp.key = '_MainTex') as main_tex,
		MAX(vp.value) FILTER (
		WHERE vp.key = '_ShadeTexture') as shade_texture,
		MAX(vp.value) FILTER (
		WHERE vp.key = '_BumpMap') as bump_map,
		MAX(vp.value) FILTER (
		WHERE vp.key = '_ReceiveShadowTexture') as receive_shadow_texture,
		MAX(vp.value) FILTER (
		WHERE vp.key = '_ShadingGradeTexture') as shading_grade_texture,
		MAX(vp.value) FILTER (
		WHERE vp.key = '_SphereAdd') as sphere_add,
		MAX(vp.value) FILTER (
		WHERE vp.key = '_EmissionColor') as emission_color,
		MAX(vp.value) FILTER (
		WHERE vp.key = '_EmissionMap') as emission_map,
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
	
	var vrm_data = db.fetch_array("SELECT * FROM vrm_material LIMIT 1")
	print(vrm_data)
	
	vrm_data = db.fetch_array("SELECT * FROM vrm_meta")
	print(vrm_data)
	
	vrm_data = db.fetch_array("SELECT * FROM vrm_bone LIMIT 1")
	print(vrm_data)
	
	# Close database
	db.close();
	
	





