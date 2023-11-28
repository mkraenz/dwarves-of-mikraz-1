extends PanelContainer

const NeededItemPanel = preload("res://ui/buildings/craft/needed_item_panel/needed_item_panel.tscn")

signal building_changed

@onready var needs_list := $V/Needs
@onready var building_name = $V/M/Heading
var ginventory := GInventory
var gdata := GData

## type: Building
var building: Dictionary = {}:
	set = _set_building


func _set_building(val: Dictionary) -> void:
	building = val
	building_changed.emit()
	_on_building_changed()


func _ready():
	Utils.remove_all_children(needs_list)


func _on_building_changed() -> void:
	building_name.text = building.label
	Utils.remove_all_children(needs_list)
	for need in building.needs:
		var panel = NeededItemPanel.instantiate()
		panel.in_stock = ginventory.inventory[need.id].amount
		panel.needed = need.amount
		panel.item_name = gdata.get_localized_item_label(need.id)
		panel.item_icon = gdata.get_item_icon(need.id)
		needs_list.add_child(panel)
		panel.refresh()
