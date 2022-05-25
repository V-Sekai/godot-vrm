@tool
extends EditorSceneFormatImporter


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
	var extension : GLTFDocumentExtension = load("res://addons/vrm/vrm_extension.gd").new()
	gltf.extensions.push_front(extension)
	var state : GLTFState = GLTFState.new()
	var err = gltf.append_from_file(path, state, flags, bake_fps)
	if err != OK:
		return null
	return gltf.generate_scene(state, bake_fps)
