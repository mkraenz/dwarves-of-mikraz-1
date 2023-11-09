extends Node2D

var eventbus := Eventbus


func _input(_event) -> void:
	# TODO this code is for easy debugging and testing. feature flag once we have a build menu
	if Input.is_action_just_pressed("test"):
		pass

	if Input.is_action_just_pressed("toggle_building_menu"):
		eventbus.toggle_building_menu.emit()


func _on_production_takt_timeout():
	eventbus.production_tick.emit()
