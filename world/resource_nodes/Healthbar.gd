extends ProgressBar

@export var stats: Stats


func _ready():
	value = stats.hp
	max_value = stats.max_hp
	stats.max_hp_changed.connect(func(_x): refresh())
	stats.hp_changed.connect(func(_x): refresh())
	refresh_visibility()


func refresh() -> void:
	max_value = stats.max_hp
	value = stats.hp
	refresh_visibility()


func refresh_visibility() -> void:
	if value != max_value:
		show()
	else:
		hide()
