extends GLTFDocumentExtension

func _import_preflight(gstate: GLTFState, extensions: PackedStringArray = PackedStringArray(), psa2: Variant = null) -> Error:
	var joints: Dictionary
	var skins:Array = gstate.json.get("skins", Array())
	var top_level_bones: Array[int] = []
	var skin: Dictionary = joints
	var nodes: Array = gstate.json["nodes"]
	for node_i in range(nodes.size()):
		var node: Dictionary = nodes[node_i]
		if node.name.to_lower() == "hips" or node.name.to_lower() == "root":
			top_level_bones.push_back(node_i)
	joints["joints"] = top_level_bones
	skins.append(skin)
	gstate.json["skins"] = skins
	return OK
