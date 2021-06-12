extends Spatial

func _ready():
	var vrm_loader = load("res://addons/vrm/vrm_loader.gd").new()
	
	var model: Spatial = vrm_loader.import_scene("res://vrm_samples/AliciaSolid_vrm-0.51.vrm", 1, 1000)
	print(model) # Either print [Spatial:some_number] or the error code
	
	call_deferred("add_child", model)
