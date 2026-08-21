@tool
extends EditorScenePostImportPlugin

signal foo

func _get_import_options(path: String):
	if path.is_empty() or path.get_extension().to_lower() == "vrm":
		add_import_option_advanced(TYPE_INT, "vrm/embedded_image_handling",
			GLTFState.HandleBinaryImageMode.HANDLE_BINARY_IMAGE_MODE_EMBED_AS_BASISU, PROPERTY_HINT_ENUM,
			"Discard All Textures,Extract Textures,Embed as Basis Universal,Embed as Uncompressed")
		add_import_option_advanced(TYPE_INT, "vrm/head_hiding_method", 0, PROPERTY_HINT_ENUM,
			"ThirdPersonOnly,FirstPersonOnly,FirstWithShadow,Layers,LayersWithShadow,IgnoreHeadHiding")
		add_import_option_advanced(TYPE_INT, "vrm/only_if_head_hiding_uses_layers/first_person_layers", 2, PROPERTY_HINT_LAYERS_3D_RENDER)
		add_import_option_advanced(TYPE_INT, "vrm/only_if_head_hiding_uses_layers/third_person_layers", 4, PROPERTY_HINT_LAYERS_3D_RENDER)
