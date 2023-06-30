@tool
extends Resource

const vrm1_collider = preload("./vrm1_collider.gd")

# For organizational purposes only. At runtime, all colliders can be combined.
@export var colliders: Array[vrm1_collider]
