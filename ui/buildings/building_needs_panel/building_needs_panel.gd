extends PanelContainer

const NeededItemPanel = preload("res://ui/buildings/craft/needed_item_panel/needed_item_panel.tscn")

signal building_changed

@onready var needs_list := $V/Needs
var ginventory := GInventory
var gdata := GData

## type: Building
var building: Dictionary = {}:
	set = _set_building


func _set_building(val: Dictionary) -> void:
	if val != building:
		building = val
		building_changed.emit()


func _ready():
	Utils.remove_all_children(needs_list)
	building_changed.connect(_on_building_changed)


func _on_building_changed() -> void:
	Utils.remove_all_children(needs_list)
	for need in building.needs:
		var panel = NeededItemPanel.instantiate()
		panel.in_stock = ginventory.inventory[need.id].amount
		panel.needed = need.amount
		panel.item_name = gdata.get_item(need.id).label
		panel.item_icon = gdata.get_item_icon(need.id)
		needs_list.add_child(panel)
		panel.refresh()
