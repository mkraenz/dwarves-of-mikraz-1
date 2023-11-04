extends Control

const ItemPanel = preload("res://ui/buildings/craft/item_panel/item_panel.tscn")

## Array of Dictionaries
var recipes: Array

@onready var grid := $M/H/AvailableItemsGrid
@onready var recipe_details := $M/H/V/RecipeDetailsCard

var selected_id


func refresh() -> void:
	Utils.remove_all_children(grid)
	for recipe in recipes:
		var panel = ItemPanel.instantiate()
		panel.recipe = recipe
		grid.add_child(panel)
		panel.selected.connect(_on_panel_selected)

	if len(recipes) == 0:
		print(name, "WARNING: No recipes available")
		return
	if not selected_id:
		_on_panel_selected(recipes[0].id)


func _on_panel_selected(recipe_id: String) -> void:
	selected_id = recipe_id
	var matching_recipes = recipes.filter(func(r): return r.id == recipe_id)
	recipe_details.recipe = matching_recipes[0]
	recipe_details.refresh()
