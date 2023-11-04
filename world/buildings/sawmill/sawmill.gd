extends StaticBody2D

@export var interactable := true

var eventbus := Eventbus

@onready var how_to_use := $HowToUse


func interact() -> void:
	# TODO #1 toggle instead
	eventbus.open_crafting_menu.emit("sawmill")


func mark() -> void:
	how_to_use.show()


func unmark() -> void:
	print("unmark sawmill")
	how_to_use.hide()
