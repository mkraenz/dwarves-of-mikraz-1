extends Control

const ItemPanel = preload("res://ui/buildings/craft/item_panel/item_panel.tscn")

## Array of Dictionaries
var recipes: Array

@onready var grid := $M/H/AvailableItemsGrid
@onready var testdeleteme := $M/H/V/M/V/Needs/NeededItemPanel


func refresh() -> void:
	_clear_grid()
	for recipe in recipes:
		var panel = ItemPanel.instantiate()
		panel.recipe = recipe
		grid.add_child(panel)

	testdeleteme.refresh()


func _clear_grid() -> void:
	for node in grid.get_children():
		grid.remove_child(node)
		node.queue_free()
