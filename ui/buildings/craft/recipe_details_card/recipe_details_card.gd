extends Container

const NeededItemPanel = preload("res://ui/buildings/craft/needed_item_panel/needed_item_panel.tscn")

@export var recipe: Dictionary
@export var batches = 1

@onready var needs_list := $V/M2/Needs
@onready var crafted_item_label := $V/M/CraftedItemLabel
@onready var needs_heading := $V/NeedsLabel
var ginventory := GInventory
var gdata := GData


func refresh() -> void:
	Utils.remove_all_children(needs_list)
	for need in recipe.needs:
		var panel = NeededItemPanel.instantiate()
		panel.in_stock = ginventory.inventory[need.id].amount
		panel.needed = need.amount * batches if batches != INF else need.amount
		needs_heading.text = "Materials" if batches != INF else "Materials (batch)"
		panel.item_name = gdata.get_item(need.id).label
		panel.item_icon = gdata.get_item_icon(need.id)
		needs_list.add_child(panel)
		panel.refresh()

	crafted_item_label.text = "%s x%s" % [gdata.items[recipe.item_id].label, recipe.batch_size]
