@tool
extends EditorPlugin

var import_plugin

const VRMC_node_constraint = preload("./1.0/VRMC_node_constraint.gd")
var VRMC_node_constraint_inst = VRMC_node_constraint.new()

const VRMC_springBone = preload("./1.0/VRMC_springBone.gd")
var VRMC_springBone_inst = VRMC_springBone.new()

const VRMC_materials_mtoon = preload("./1.0/VRMC_materials_mtoon.gd")
var VRMC_materials_mtoon_inst = VRMC_materials_mtoon.new()

const VRMC_materials_hdr_emissiveMultiplier = preload("./1.0/VRMC_materials_hdr_emissiveMultiplier.gd")
var VRMC_materials_hdr_emissiveMultiplier_inst = VRMC_materials_hdr_emissiveMultiplier.new()

const VRMC_vrm = preload("./1.0/VRMC_vrm.gd")
var VRMC_vrm_inst = VRMC_vrm.new()

const VRMC_vrm_animation = preload("./1.0/VRMC_vrm_animation.gd")
var VRMC_vrm_animation_inst = VRMC_vrm_animation.new()

const vrm_meta_class = preload("./vrm_meta.gd")
const vrm_top_level = preload("./vrm_toplevel.gd")
const vrm_secondary = preload("./vrm_secondary.gd")

#const vrm_export_extension = preload("./1.0/vrm_export_extension.gd")
#var vrm_export_extension_inst = vrm_export_extension.new()


const export_as_item: String = "VRM 1.0 Avatar..."
const export_as_id: int = 0x56524d31 # 'VRM1'

var file_export_lib: EditorFileDialog
var accept_dialog: AcceptDialog

func _export_vrm_pressed():
	var root = get_tree().get_edited_scene_root()
	if not root:
		accept_dialog.text = "This operation can't be done without a scene."
		accept_dialog.ok_button_text = "OK"
		get_editor_interface().popup_dialog_centered(accept_dialog)
		return

	var filename: String = root.get_scene_file_path().get_file().get_basename()
	if filename.is_empty():
		filename = root.get_name()
	file_export_lib.set_current_file(filename + ".vrm")
	file_export_lib.popup_centered_ratio()

func _export_vrm_dialog_action(path: String):
	var selected_nodes: Array[Node] = get_editor_interface().get_selection().get_selected_nodes()
	for selnode in selected_nodes:
		if selnode.script != vrm_top_level:
			var bleh: Array[Node]
			selected_nodes = bleh
			break
	if selected_nodes.is_empty():
		var bleh: Array[Node]
		selected_nodes = bleh
		selected_nodes.append(get_tree().get_edited_scene_root())
	for root in selected_nodes:
		if root.script != vrm_top_level:
			accept_dialog.text = "VRM Export requires the selected or top-level node to contain a vrm_top_level script with meta."
			accept_dialog.ok_button_text = "OK"
			get_editor_interface().popup_dialog_centered(accept_dialog)
			continue
		root.vrm_meta = vrm_meta_class.new()
		var secondary: Node3D
		if not root.has_node("secondary"):
			secondary = Node3D.new()
			secondary.owner = root
			root.add_child(secondary)
		else:
			secondary = root.get_node("secondary")
		if secondary.script == null:
			secondary.script = vrm_secondary

		var gltf_doc = GLTFDocument.new()
		var gltf_state = GLTFState.new()
		gltf_state.set_meta("vrm", "1.0")
		var flags = EditorSceneFormatImporter.IMPORT_USE_NAMED_SKIN_BINDS
		if gltf_doc.append_from_scene(root, gltf_state, flags) != OK:
			push_error("VRM scene save error!")
		if gltf_doc.write_to_filesystem(gltf_state, path) != OK:
			push_error("VRM scene save error!")

func _enter_tree() -> void:
	accept_dialog = AcceptDialog.new()
	accept_dialog.set_unparent_when_invisible(true)

	file_export_lib = EditorFileDialog.new()
	# get_gui_base().
	add_child(file_export_lib)
	file_export_lib.file_selected.connect(_export_vrm_dialog_action)
	file_export_lib.set_title("Export VRM File")
	file_export_lib.set_file_mode(EditorFileDialog.FILE_MODE_SAVE_FILE)
	file_export_lib.set_access(EditorFileDialog.ACCESS_FILESYSTEM)
	file_export_lib.clear_filters()
	file_export_lib.add_filter("*.vrm")
	file_export_lib.set_title("Export Scene to VRM 1.0 File")

	var export_as_menu: PopupMenu = get_export_as_menu()
	if export_as_menu != null:
		for i in range(export_as_menu.item_count - 1, -1, -1):
			if export_as_menu.get_item_text(i) == export_as_item:
				export_as_menu.remove_item(i)
	export_as_menu.add_item(export_as_item, export_as_id, KEY_V)
	export_as_menu.set_item_metadata(export_as_menu.item_count - 1, _export_vrm_pressed)

	# NOTE: Be sure to also register at runtime if you want runtime import.
	# This editor plugin script won't run outside of the editor.
	GLTFDocument.register_gltf_document_extension(VRMC_vrm_inst)
	GLTFDocument.register_gltf_document_extension(VRMC_node_constraint_inst)
	GLTFDocument.register_gltf_document_extension(VRMC_springBone_inst)
	GLTFDocument.register_gltf_document_extension(VRMC_materials_mtoon_inst)
	GLTFDocument.register_gltf_document_extension(VRMC_materials_hdr_emissiveMultiplier_inst)
	#GLTFDocument.register_gltf_document_extension(VRMC_vrm_animation_inst)
	import_plugin = preload("res://addons/vrm/import_vrm.gd").new()
	add_scene_format_importer_plugin(import_plugin)


func _exit_tree() -> void:
	accept_dialog.queue_free()
	file_export_lib.queue_free()
	var export_as_menu: PopupMenu = get_export_as_menu()
	if export_as_menu != null:
		for i in range(export_as_menu.item_count - 1, -1, -1):
			if export_as_menu.get_item_text(i) == export_as_item:
				export_as_menu.remove_item(i)
	GLTFDocument.unregister_gltf_document_extension(VRMC_vrm_inst)
	GLTFDocument.unregister_gltf_document_extension(VRMC_node_constraint_inst)
	GLTFDocument.unregister_gltf_document_extension(VRMC_springBone_inst)
	GLTFDocument.unregister_gltf_document_extension(VRMC_materials_mtoon_inst)
	GLTFDocument.unregister_gltf_document_extension(VRMC_materials_hdr_emissiveMultiplier_inst)
	#GLTFDocument.unregister_gltf_document_extension(VRMC_vrm_animation_inst)
	remove_scene_format_importer_plugin(import_plugin)
	import_plugin = null
