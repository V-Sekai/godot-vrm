@tool
extends EditorPlugin

var import_plugin

func _enter_tree() -> void:
	import_plugin = preload("./import_vrm.gd").new()
	add_scene_format_importer_plugin(import_plugin)


func _exit_tree() -> void:
	remove_scene_format_importer_plugin(import_plugin)
	import_plugin = null
