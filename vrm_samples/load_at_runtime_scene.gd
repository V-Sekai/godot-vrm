extends Node3D

var _model: Node3D = null

func _ready():
	get_tree().root.files_dropped.connect(func(files: PackedStringArray) -> void:
		if files.size() != 1:
			printerr("This demo only handles loading 1 model at a time.")
			return
		
		var file_path := files[0]
		if not file_path.get_extension().to_lower() in ["vrm", "glb"]:
			printerr("This demo only handles vrm and glb files.")
			return
		
		var model: Node3D = _load_model(file_path)
		if model == null:
			printerr("Failed to load model from path %s" % file_path)
			return
		
		if _model != null:
			_model.free()
		
		_model = model
		add_child(model)
	)
	
	_model = _load_model("res://vrm_samples/AliciaSolid_vrm-0.51.vrm")
	add_child(_model)

func _load_model(path: String) -> Node3D:
	var gltf: GLTFDocument = GLTFDocument.new()
	var vrm_extension: GLTFDocumentExtension = preload("res://addons/vrm/vrm_extension.gd").new()
	gltf.register_gltf_document_extension(vrm_extension, true)
	
	var state: GLTFState = GLTFState.new()
	# state.handle_binary_image = GLTFState.HANDLE_BINARY_EMBED_AS_BASISU

	# Ensure Tangents is required for meshes with blend shapes as of Godot 4.2.
	# EditorSceneFormatImporter.IMPORT_GENERATE_TANGENT_ARRAYS = 8
	# EditorSceneFormatImporter may not be available in release builds, so hardcode 8 for flags
	var err = gltf.append_from_file(path, state, 8)
	if err != OK:
		gltf.unregister_gltf_document_extension(vrm_extension)
		return null
	
	var generated_scene = gltf.generate_scene(state)
	
	gltf.unregister_gltf_document_extension(vrm_extension)
	
	return generated_scene
