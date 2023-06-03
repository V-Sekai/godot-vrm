@tool
extends EditorPlugin

var import_plugin


func _enter_tree() -> void:
	# NOTE: Be sure to also register at runtime if you want runtime import.
	# This editor plugin script won't run outside of the editor.
	import_plugin = preload("res://addons/vrm/import_vrm.gd").new()
	add_scene_format_importer_plugin(import_plugin)


func _exit_tree() -> void:
	remove_scene_format_importer_plugin(import_plugin)
	import_plugin = null
