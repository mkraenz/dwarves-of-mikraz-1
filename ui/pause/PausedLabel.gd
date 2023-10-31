extends Label

var TIMEOUT_SEC = 1
var original_modulate_alpha: float


func _ready() -> void:
	original_modulate_alpha = modulate.a
	blink()


func blink() -> void:
	await get_tree().create_timer(TIMEOUT_SEC).timeout
	modulate.a = original_modulate_alpha if modulate.a == 0 else 0.0
	blink()
