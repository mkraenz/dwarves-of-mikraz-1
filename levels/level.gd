extends Node2D

var eventbus := Eventbus
var gstate := GState


func _ready():
	gstate.level = self
	if not QuestLog.is_quest_started("main1"):
		QuestLog.start_quest("main1")


func _input(_event) -> void:
	if Input.is_action_just_pressed("toggle_building_menu"):
		eventbus.toggle_building_menu.emit()

	if Input.is_action_just_pressed("toggle_inventory_menu"):
		eventbus.toggle_inventory_menu.emit()


func _on_production_takt_timeout():
	eventbus.production_tick.emit()
