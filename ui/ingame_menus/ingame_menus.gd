extends Control

var eventbus := Eventbus
var gdata := GData
var gstate := GState

@onready var crafting_menu := $CraftingMenu
@onready var inventory_menu := $InventoryMenu
@onready var building_menu := $BuildingMenu


func _ready() -> void:
	eventbus.toggle_crafting_menu.connect(_on_toggle_crafting_menu)
	eventbus.toggle_building_menu.connect(_on_toggle_building_menu)
	eventbus.toggle_inventory_menu.connect(_on_toggle_inventory_menu)
	eventbus.enter_build_mode.connect(_on_enter_build_mode)


func hide_children():
	for child in get_children():
		child.hide()
	show()


func _on_toggle_crafting_menu(for_building: String, workshop_node_path: String) -> void:
	crafting_menu.workshop_node_path = workshop_node_path
	crafting_menu.recipes = gdata.crafting_recipes[for_building]
	crafting_menu.soft_reset()
	crafting_menu.refresh()
	toggle_child(crafting_menu)


func _on_toggle_building_menu() -> void:
	toggle_child(building_menu)


func _on_enter_build_mode(_building_id: String) -> void:
	hide_children()
	gstate.mode = GState.Mode.build


func _on_toggle_inventory_menu() -> void:
	toggle_child(inventory_menu)


func toggle_child(target: Control) -> void:
	hide_children_except(target)
	target.visible = not target.visible


func hide_children_except(exception: Control) -> void:
	for child in get_children():
		if child != exception:
			child.hide()
