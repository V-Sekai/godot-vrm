@tool
extends EditorSceneFormatImporter


const gltf_document_extension_class = preload("res://addons/vrm/vrm_extension.gd")

func _get_importer_name() -> String:
	return "Godot-VRM"


func _get_recognized_extensions() -> Array:
	return ["vrm"]


func _get_extensions() -> PackedStringArray:
	var exts : PackedStringArray
	exts.push_back("vrm")
	return exts


func _get_import_flags() -> int:
	return IMPORT_SCENE


func _import_animation(path: String, flags: int, options: Dictionary, bake_fps: int) -> Animation:
	return Animation.new()


func _import_scene(path: String, flags: int, options: Dictionary, bake_fps: int) -> Object:
	var gltf : GLTFDocument = GLTFDocument.new()
	var extension : GLTFDocumentExtension = gltf_document_extension_class.new()
	gltf.extensions.push_front(extension)
	var state : GLTFState = GLTFState.new()
	var err = gltf.append_from_file(path, state, flags, bake_fps)
	if err != OK:
		return null

	var generated_scene = gltf.generate_scene(state, bake_fps)

	var bm: Dictionary = {}

	var vrm_meta: Resource = extension.vrm_meta
	var skel_path: NodePath = vrm_meta.humanoid_skeleton_path
	var humanoid_bone_mapping: BoneMap = vrm_meta.humanoid_bone_mapping
	# Advanced... dialog runs a copy of import with options["_subresources"] undefined.
	if options.has("_subresources"):
		print(options)
		var subresdict: Dictionary = options["_subresources"]
		if not subresdict.has("nodes"):
			print("Adding new 'nodes'")
			subresdict["nodes"] = {}
		var skel_node_key: String = "PATH:" + str(skel_path)
		var existing_bone_map: BoneMap = subresdict.get("nodes", {}).get(skel_node_key, {}).get("retarget/bone_map", null)
		if existing_bone_map == null:
			existing_bone_map = BoneMap.new()
		if existing_bone_map.profile == null:
			existing_bone_map.profile = humanoid_bone_mapping.profile
		if existing_bone_map != null:
			for k in range(humanoid_bone_mapping.profile.bone_size):
				var prof_bone: StringName = humanoid_bone_mapping.profile.get_bone_name(k)
				bm[prof_bone] = existing_bone_map.get_skeleton_bone_name(prof_bone)
				existing_bone_map.set_skeleton_bone_name(prof_bone, humanoid_bone_mapping.get_skeleton_bone_name(prof_bone))
		print(bm)
		if not subresdict["nodes"].has(skel_node_key):
			print("Adding new 'nodes' / " + str(skel_node_key))
			subresdict["nodes"][skel_node_key] = {}

		bm = {}
		if humanoid_bone_mapping != null:
			for k in range(humanoid_bone_mapping.profile.bone_size):
				bm[humanoid_bone_mapping.profile.get_bone_name(k)] = humanoid_bone_mapping.get_skeleton_bone_name(humanoid_bone_mapping.profile.get_bone_name(k))
		print("Final")
		print(bm)
		subresdict["nodes"][skel_node_key]["retarget/bone_map"] = existing_bone_map

	print(options)
	return generated_scene
