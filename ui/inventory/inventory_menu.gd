extends Control

var ginventory := GInventory
var gdata := GData
var gstate := GState
var eventbus := Eventbus

@onready var item_list: ItemList = $M/P/M/H/ItemList


func _physics_process(_delta: float) -> void:
	if visible:
		redraw_data()


func _ready():
	fill_item_list()


func _input(_event):
	if visible and Input.is_action_just_pressed("close"):
		close_menu()


func redraw_data() -> void:
	# Godot's ItemLists are so ugly to use... they only allow access via index.
	# So we have to make sure that ginventory.inventory's items and the item list stay in the same order. Not great
	var i := 0
	for item_key in ginventory.inventory:
		var inventory_item = ginventory.inventory[item_key]
		item_list.set_item_text(i, str(inventory_item.amount))
		i += 1


func fill_item_list() -> void:
	# Godot's ItemLists are so ugly to use... they only allow access via index.
	# So we have to make sure that ginventory.inventory's items and the item list stay in the same order. Not great
	item_list.clear()
	for item_key in ginventory.inventory:
		var inventory_item = ginventory.inventory[item_key]
		var item := gdata.get_item(item_key)
		var icon = gdata.get_item_icon(item_key)
		var i = item_list.add_item(str(inventory_item.amount), icon)
		item_list.set_item_metadata(i, item_key)
		item_list.set_item_tooltip(i, item.label)


func close_menu():
	hide()
