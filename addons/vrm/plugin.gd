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



func _enter_tree() -> void:
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
	GLTFDocument.unregister_gltf_document_extension(VRMC_vrm_inst)
	GLTFDocument.unregister_gltf_document_extension(VRMC_node_constraint_inst)
	GLTFDocument.unregister_gltf_document_extension(VRMC_springBone_inst)
	GLTFDocument.unregister_gltf_document_extension(VRMC_materials_mtoon_inst)
	GLTFDocument.unregister_gltf_document_extension(VRMC_materials_hdr_emissiveMultiplier_inst)
	#GLTFDocument.unregister_gltf_document_extension(VRMC_vrm_animation_inst)
	remove_scene_format_importer_plugin(import_plugin)
	import_plugin = null
