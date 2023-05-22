extends Node3D

func _ready():
	var model: Node3D = _load_model("res://vrm_samples/AliciaSolid_vrm-0.51.vrm")

	add_child(model)

func _load_model(path: String) -> Node:
	var gltf: GLTFDocument = GLTFDocument.new()
	var vrm_extension: GLTFDocumentExtension = preload("res://addons/vrm/vrm_extension.gd").new()
	gltf.register_gltf_document_extension(vrm_extension, true)
	
	var state: GLTFState = GLTFState.new()
	state.handle_binary_image = GLTFState.HANDLE_BINARY_EMBED_AS_BASISU
	var err = gltf.append_from_file(path, state)
	if err != OK:
		gltf.unregister_gltf_document_extension(vrm_extension)
		return null
	
	var generated_scene = gltf.generate_scene(state)
	
	gltf.unregister_gltf_document_extension(vrm_extension)
	
	return generated_scene
