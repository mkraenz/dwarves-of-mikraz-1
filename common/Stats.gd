extends Node2D
class_name Stats

signal hp_changed(new_amount: float)
signal max_hp_changed(new_amount: float)
signal no_health

@export var max_hp: float = 5.0:
	set = _set_max_hp

var hp: float = max_hp:
	set = _set_hp


func _set_hp(val: float) -> void:
	if hp != val:
		hp = max(val, 0.0)
		hp_changed.emit(hp)
	if hp <= 0:
		no_health.emit()


func _set_max_hp(val: float) -> void:
	if max_hp != val:
		max_hp = max(val, 0.0)
		max_hp_changed.emit(max_hp)
		hp = max_hp


func save() -> Dictionary:
	var save_dict = {"hp": hp, "max_hp": max_hp}
	return save_dict


func load_from(save_dict: Dictionary) -> void:
	hp = save_dict.hp
	max_hp = save_dict.max_hp
