extends StaticBody2D

@export var interactable := true

var eventbus := Eventbus

@onready var how_to_use := $HowToUse


func interact() -> void:
	eventbus.toggle_crafting_menu.emit("sawmill")


func mark() -> void:
	how_to_use.show()


func unmark() -> void:
	how_to_use.hide()
