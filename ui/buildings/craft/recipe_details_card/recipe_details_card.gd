extends MarginContainer

const NeededItemPanel = preload("res://ui/buildings/craft/needed_item_panel/needed_item_panel.tscn")

@export var recipe: Dictionary
@export var multiplier = 1

@onready var needs_list := $V/Needs
@onready var crafted_item_label := $V/CraftedItemLabel
var ginventory := GInventory
var gdata := GData


func refresh() -> void:
	Utils.remove_all_children(needs_list)
	for need in recipe.needs:
		var panel = NeededItemPanel.instantiate()
		panel.in_stock = ginventory.inventory[need.id].amount
		panel.needed = need.amount * multiplier
		panel.item_name = gdata.items[need.id].label
		needs_list.add_child(panel)
		panel.refresh()

	crafted_item_label.text = "%s x%s" % [gdata.items[recipe.id].label, recipe.outputAmount]
