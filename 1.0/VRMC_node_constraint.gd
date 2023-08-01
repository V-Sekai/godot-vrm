@tool
extends GLTFDocumentExtension

const bone_node_constraint = preload("../node_constraint/bone_node_constraint.gd")
const bone_node_constraint_applier = preload("../node_constraint/bone_node_constraint_applier.gd")


func _import_preflight(_state: GLTFState, extensions: PackedStringArray) -> Error:
	if extensions.has("VRMC_node_constraint"):
		return OK
	return ERR_SKIP


func _parse_node_extensions(gltf_state: GLTFState, gltf_node: GLTFNode, node_extensions: Dictionary) -> Error:
	if not node_extensions.has("VRMC_node_constraint"):
		return OK
	var constraint_ext: Dictionary = node_extensions["VRMC_node_constraint"]
	var constraint: bone_node_constraint = bone_node_constraint.from_dictionary(constraint_ext)
	gltf_node.set_additional_data(&"BoneNodeConstraint", constraint)
	return OK


func _import_post_parse(gltf_state: GLTFState) -> Error:
	var applier: bone_node_constraint_applier = bone_node_constraint_applier.new()
	applier.name = &"BoneNodeConstraintApplier"
	gltf_state.set_additional_data(&"BoneNodeConstraintApplier", applier)
	# Add the constraint applier to the real root, next to the AnimationPlayer.
	var gltf_root: Node = gltf_state.get_scene_node(gltf_state.root_nodes[0])
	var real_root = gltf_root.get_parent()
	real_root.add_child(applier)
	applier.owner = real_root
	return OK


func _import_post(gstate: GLTFState, node: Node) -> Error:
	var nodes: Array = gstate.nodes
	var json_nodes: Array = gstate.json["nodes"]
	for i in range(len(nodes)):
		var err: Error = my_import_node(gstate, nodes[i], json_nodes[i], gstate.get_scene_node(i))
		if err != OK:
			return err
	return OK


func my_import_node(gltf_state: GLTFState, gltf_node: GLTFNode, json: Dictionary, node: Node) -> Error:
	var constraint: bone_node_constraint = gltf_node.get_additional_data(&"BoneNodeConstraint")
	if not constraint:
		return OK
	var gltf_nodes: Array[GLTFNode] = gltf_state.nodes
	var gltf_skeletons: Array[GLTFSkeleton] = gltf_state.skeletons
	constraint.resource_name = str(gltf_node.resource_name) + " from " + str(gltf_nodes[constraint.source_node_index].resource_name)
	# Set up the source node.
	constraint.source_node = gltf_state.get_scene_node(constraint.source_node_index)
	constraint.source_rest_transform = constraint.source_node.transform
	if gltf_nodes[constraint.source_node_index].skeleton != -1:
		var godot_skel: Skeleton3D = gltf_skeletons[gltf_nodes[constraint.source_node_index].skeleton].get_godot_skeleton()
		var source_bone_name: String = gltf_nodes[constraint.source_node_index].resource_name
		constraint.source_bone_index = godot_skel.find_bone(source_bone_name)
		constraint.source_node = godot_skel
		# Edge case: Even though we have been given the Skeleton by Godot, and
		# this is almost certainly a bone, it could be the Skeleton node itself.
		if constraint.source_bone_index != -1:
			constraint.source_rest_transform = godot_skel.get_bone_rest(constraint.source_bone_index)
	# Set up the target node. NOTE: It seems similar to the source node code,
	# however there are a ton of subtle differences, so it should be duplicated.
	constraint.target_node = node
	constraint.target_rest_transform = node.transform
	if gltf_node.skeleton != -1:
		var godot_skel: Skeleton3D = gltf_skeletons[gltf_node.skeleton].get_godot_skeleton()
		constraint.target_bone_index = godot_skel.find_bone(gltf_node.resource_name)
		constraint.target_node = godot_skel
		# Edge case: Even though we have been given the Skeleton by Godot, and
		# this is almost certainly a bone, it could be the Skeleton node itself.
		if constraint.target_bone_index != -1:
			constraint.target_rest_transform = godot_skel.get_bone_rest(constraint.target_bone_index)
	# Set node paths relative to the applier and save to the applier.
	var applier: bone_node_constraint_applier = gltf_state.get_additional_data(&"BoneNodeConstraintApplier")
	applier.constraints.append(constraint)
	constraint.set_node_paths_from_references(applier)
	return OK


# Export process.
func _convert_scene_node(gltf_state: GLTFState, gltf_node: GLTFNode, scene_node: Node) -> void:
	if not scene_node is bone_node_constraint_applier:
		return
	var applier: bone_node_constraint_applier = scene_node
	gltf_state.set_additional_data(&"BoneNodeConstraintApplier", scene_node)
	gltf_state.add_used_extension("VRMC_node_constraint", false)
	for constraint in applier.constraints:
		constraint.set_node_references_from_paths(applier)


func _export_post(gltf_state: GLTFState):
	var applier: bone_node_constraint_applier = gltf_state.get_additional_data(&"BoneNodeConstraintApplier")
	if applier == null:
		return OK
	var node_to_index: Dictionary
	for i in range(gltf_state.get_nodes().size()):
		var scene_node: Node = gltf_state.get_scene_node(i)
		node_to_index[scene_node] = i
	var skeletons: Array[GLTFSkeleton] = gltf_state.skeletons

	for constraint in applier.constraints:
		if not constraint:
			return ERR_INVALID_DATA
		# TODO: Use get_node_index() once we stop supporting 4.0.x.
		# See https://github.com/godotengine/godot/pull/77534
		if constraint.source_node is Skeleton3D:
			for gltf_skel in skeletons:
				if gltf_skel.get_godot_skeleton() == constraint.source_node:
					constraint.source_node_index = gltf_skel.godot_bone_node[constraint.source_bone_index]
		else:
			constraint.source_node_index = node_to_index[constraint.source_node]
		var target_node_index: int = -1
		if constraint.target_node is Skeleton3D:
			for gltf_skel in skeletons:
				if gltf_skel.get_godot_skeleton() == constraint.target_node:
					target_node_index = gltf_skel.godot_bone_node[constraint.target_bone_index]
		else:
			target_node_index = node_to_index[constraint.target_node]
		var json_nodes: Array = gltf_state.json["nodes"]
		var json: Dictionary = json_nodes[target_node_index]
		if not json.has("extensions"):
			json["extensions"] = {}
		var extensions: Dictionary = json["extensions"]
		extensions["VRMC_node_constraint"] = constraint.to_dictionary()
	return OK
