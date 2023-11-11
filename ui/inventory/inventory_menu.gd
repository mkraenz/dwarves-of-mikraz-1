extends Control

var ginventory := GInventory
var gdata := GData
var gstate := GState

@onready var item_list = $M/ScrollContainer/ItemList


func _ready():
	hide()


func _input(_event):
	if Input.is_action_just_pressed("toggle_inventory"):
		if gstate.is_ingame:
			visible = not visible


func _physics_process(_delta: float) -> void:
	if visible:
		redraw_data()


func redraw_data() -> void:
	Utils.remove_all_children(item_list)

	for item_key in ginventory.inventory.keys():
		var inventory_item = ginventory.inventory[item_key]
		var item = gdata.items[item_key]
		var label = Label.new()
		label.text = "%s : %s" % [item.label, inventory_item.amount]
		item_list.add_child(label)
