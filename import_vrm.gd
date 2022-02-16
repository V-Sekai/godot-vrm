@tool
extends EditorSceneFormatImporter


func _get_importer_name() -> String:
	return "Godot-VRM"


func _get_recognized_extensions() -> Array:
	return ["vrm"]


func _get_extensions() -> Array:
	return ["vrm"]


func _get_import_flags() -> int:
	return IMPORT_SCENE


func _import_animation(path: String, flags: int, options: Dictionary, bake_fps: int) -> Animation:
	return Animation.new()


func _import_scene(path: String, flags: int, options: Dictionary, bake_fps: int) -> Node:
	var vrm_loader = load("res://addons/vrm/vrm_loader.gd").new()
	
	var root_node = vrm_loader.import_scene(path, flags, bake_fps)
	
	if typeof(root_node) == TYPE_INT:
		return root_node # Error code
	return root_node
