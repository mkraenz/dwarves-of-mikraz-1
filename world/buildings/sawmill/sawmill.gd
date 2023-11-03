extends StaticBody2D

@export var interactable := true

var eventbus := Eventbus


func interact() -> void:
	eventbus.open_crafting_menu.emit("sawmill")
