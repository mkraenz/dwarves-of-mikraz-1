extends Control

## TODO #1 rename scene to crafting menu

const ItemPanel = preload("res://ui/buildings/craft/item_panel/item_panel.tscn")

## Array of Dictionaries
var recipes: Array

@onready var grid = $M/H/AvailableItemsGrid


func refresh() -> void:
	_clear_grid()
	for recipe in recipes:
		var panel = ItemPanel.instantiate()
		panel.recipe = recipe
		grid.add_child(panel)


func _clear_grid() -> void:
	for node in grid.get_children():
		grid.remove_child(node)
		node.queue_free()
