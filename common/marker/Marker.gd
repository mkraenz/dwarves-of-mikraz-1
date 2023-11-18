extends Node2D

@export var how_to: Node2D


func mark() -> void:
	how_to.show()


func unmark() -> void:
	how_to.hide()
