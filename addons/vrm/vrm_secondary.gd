extends Resource


export var spring_bones: Array
export var collider_groups: Array


# Called when the node enters the scene tree for the first time.
func _ready():
	for bg in spring_bones:
		bg._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for bg in spring_bones:
		bg._process(delta)
