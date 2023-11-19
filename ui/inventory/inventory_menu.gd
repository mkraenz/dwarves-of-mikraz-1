extends Control

var ginventory := GInventory
var gdata := GData
var gstate := GState
var eventbus := Eventbus

@onready var item_list: ItemList = $M/P/M/V/ItemList

## workaround: Godot's ItemLists are so ugly to use... they only allow access via index. So we keep lookup tables in both directions to avoid quadratic runtime complexity.
var item_id_to_index = {}
var index_to_item_id = {}


func _physics_process(_delta: float) -> void:
	if visible:
		redraw_data()


func _ready():
	fill_item_list()
	eventbus.ginventory_overwritten.connect(_on_ginventory_overwritten)


func _input(_event):
	if visible and Input.is_action_just_pressed("close"):
		close_menu()


func redraw_data() -> void:
	for item_id in ginventory.seen_items:
		var i = item_id_to_index.get(item_id)
		if i == null:  # avoid i==0 being falsy
			add_item_to_list(item_id)
		else:
			var inventory_item = ginventory.inventory[item_id]
			item_list.set_item_text(i, str(inventory_item.amount))


func fill_item_list() -> void:
	# Godot's ItemLists are so ugly to use... they only allow access via index.
	# So we have to make sure that ginventory.inventory's items and the item list stay in the same order. Not great
	item_list.clear()
	index_to_item_id = {}
	item_id_to_index = {}
	for item_id in ginventory.seen_items:
		add_item_to_list(item_id)


func add_item_to_list(item_id) -> void:
	var inventory_item = ginventory.inventory[item_id]
	var item := gdata.get_item(item_id)
	var icon = gdata.get_item_icon(item_id)
	var i = item_list.add_item(str(inventory_item.amount), icon)
	item_list.set_item_metadata(i, item_id)
	item_list.set_item_tooltip(i, item.label)
	item_id_to_index[item_id] = i


func close_menu():
	hide()


func _on_ginventory_overwritten() -> void:
	fill_item_list()
