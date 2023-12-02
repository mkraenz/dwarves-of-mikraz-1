class_name CurrentOrderDisplay
extends Node2D

@export var TARGET_SIZE := 16.0
@onready var label = $Amount
@onready var sprite = $Sprite2D


func set_icon_texture(new_texture: Texture2D) -> void:
	sprite.texture = new_texture
	var new_scale = TARGET_SIZE / new_texture.get_width()
	sprite.scale = Vector2(new_scale, new_scale)


func set_text(remaining_amount: float) -> void:
	if remaining_amount == INF:
		label.text = "∞"
	else:
		label.text = str(remaining_amount)
