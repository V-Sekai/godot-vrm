tool
extends EditorSceneImporter


func _get_extensions():
	return ["vrm"]


func _get_import_flags():
	return EditorSceneImporter.IMPORT_SCENE


func _import_animation(path: String, flags: int, bake_fps: int):
	return Animation.new()


func _import_scene(path: String, flags: int, bake_fps: int):
	var f = File.new()
	if f.open(path, File.READ) != OK:
		return FAILED

	var magic = f.get_32()
	if magic != 0x46546C67:
		return ERR_FILE_UNRECOGNIZED
	f.get_32() # version
	f.get_32() # length

	var chunk_length = f.get_32();
	var chunk_type = f.get_32();

	if chunk_type != 0x4E4F534A:
		return ERR_PARSE_ERROR
	var json_data : PoolByteArray = f.get_buffer(chunk_length)
	f.close()

	var text : String = json_data.get_string_from_utf8()
	var gltf = PackedSceneGLTF.new()
	gltf.pack_gltf(path, 0, 1000.0)
	return gltf.instance()


func import_animation_from_other_importer(path: String, flags: int, bake_fps: int):
	return self._import_animation(path, flags, bake_fps)


func import_scene_from_other_importer(path: String, flags: int, bake_fps: int):
	return self._import_scene(path, flags, bake_fps)
