extends Sprite2D

@onready var label = $Amount


func set_text(remaining_amount: float) -> void:
	if remaining_amount == INF:
		label.text = "∞"
	else:
		label.text = str(remaining_amount)
