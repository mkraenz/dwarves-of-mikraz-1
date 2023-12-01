extends Node2D

@export var shapes: Array[CollisionShape2D]

var base_scales: Array[Vector2]


func _ready():
	# wrapped in Array constructor to fix:
	# Trying to assign an array of type "Array" to a variable of type "Array[Vector2]".
	# https://www.reddit.com/r/godot/comments/180t58w/comment/ka8jwut/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
	base_scales = Array(shapes.map(func(shape): return shape.scale), TYPE_VECTOR2, "", "")


func set_collision_scale(new_scale: float) -> void:
	for i in len(shapes):
		var shape = shapes[i]
		shape.scale = base_scales[i] * new_scale


func reset_collision_scale() -> void:
	for i in len(shapes):
		var shape = shapes[i]
		shape.scale = base_scales[i]
