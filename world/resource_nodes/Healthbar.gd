extends ProgressBar

@export var stats: Stats


func _ready():
	max_value = stats.max_hp
	stats.max_hp_changed.connect(_on_max_hp_changed)
	stats.hp_changed.connect(_on_hp_changed)
	hide()


func _on_hp_changed(hp: float) -> void:
	if hp != stats.max_hp:
		show()
	value = hp

func _on_max_hp_changed(max_hp: float) -> void:
	max_value = stats.max_hp
	value = stats.hp