extends ProgressBar

@export var stats: Stats


func _ready():
	max_value = stats.max_hp
	stats.hp_changed.connect(_on_hp_changed)
	hide()


func _on_hp_changed(hp: float) -> void:
	if hp != stats.max_hp:
		show()
	value = hp
