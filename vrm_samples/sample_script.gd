extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	var wiggle4 : Animation = $"Godette_vrm_v4/anim".get_animation("sample/wiggle4")
	wiggle4.loop_mode = Animation.LOOP_LINEAR
	$"Godette_vrm_v4/anim".play("sample/wiggle4")
	wiggle4 = $"AliciaSolid_vrm-051/anim".get_animation("sample/wiggle4")
	wiggle4.loop_mode = Animation.LOOP_LINEAR
	$"AliciaSolid_vrm-051/anim".play("sample/wiggle4")
	wiggle4 = $"AliciaSolid_vrm-052/anim".get_animation("sample/wiggle4")
	wiggle4.loop_mode = Animation.LOOP_LINEAR
	$"AliciaSolid_vrm-052/anim".play("sample/wiggle4")
