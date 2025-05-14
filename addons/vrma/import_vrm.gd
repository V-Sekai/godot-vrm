@tool
extends EditorSceneFormatImporter

const vrma_document_extension_class = preload("./vrma_extension.gd")

const SAVE_DEBUG_GLTFSTATE_RES: bool = false


func _get_importer_name() -> String:
	return "Godot-VRMA"


func _get_recognized_extensions() -> Array:
	return ["vrma"]


func _get_extensions() -> PackedStringArray:
	var exts: PackedStringArray
	exts.push_back("vrma")
	return exts


func _get_import_flags() -> int:
	return IMPORT_SCENE


func _import_scene(path: String, flags: int, options: Dictionary) -> Object:
	print("Import VRMA: " + path + " ----------------------")
	var gltf: GLTFDocument = GLTFDocument.new()
	flags |= EditorSceneFormatImporter.IMPORT_USE_NAMED_SKIN_BINDS
	var state: GLTFState = GLTFState.new()
	state.handle_binary_image = GLTFState.HANDLE_BINARY_EMBED_AS_BASISU
	var generated_scene = null
	var vrma_extension: GLTFDocumentExtension = vrma_document_extension_class.new()
	gltf.register_gltf_document_extension(vrma_extension, true)
	var err = gltf.append_from_file(path, state, flags)
	if err != OK:
		gltf.unregister_gltf_document_extension(vrma_extension)
		return null
	generated_scene = gltf.generate_scene(state)
	gltf.unregister_gltf_document_extension(vrma_extension)
	return generated_scene

