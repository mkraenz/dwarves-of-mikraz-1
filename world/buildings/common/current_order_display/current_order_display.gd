extends Sprite2D

@export var TARGET_SIZE := 16.0
@onready var label = $Amount


func set_icon_texture(_texture: Texture2D) -> void:
	texture = _texture
	var _scale = TARGET_SIZE / _texture.get_width()
	scale = Vector2(_scale, _scale)


func set_text(remaining_amount: float) -> void:
	if remaining_amount == INF:
		label.text = "∞"
	else:
		label.text = str(remaining_amount)
