extends Node

const Item = preload("res://common/item/item.gd")

signal loading_finished

var eventbus := Eventbus
var gdata := GData

## @type {{[id: string]: Item}}
var inventory: Dictionary = {}

var seen_items: Dictionary:
	get = _get_seen_items


func _get_seen_items() -> Dictionary:
	var x_seen_items := {}
	for id in inventory.keys():
		var item = inventory[id]
		if item.seen:
			x_seen_items[id] = item
	return x_seen_items


func _ready():
	reset()
	eventbus.add_to_inventory.connect(_on_add_to_inventory)


func get_item(item_id: String) -> Item:
	return inventory[item_id]


func has(item_id: String, amount: int) -> bool:
	return inventory[item_id].amount >= amount


## @param {NeededItem[]} needs
func satisfies_all_needs(needs: Array) -> bool:
	var need_fulfilled = func(need): return has(need.id, need.amount)
	return needs.all(need_fulfilled)


func get_max_producable_batches(needs: Array) -> float:
	var available_amounts = needs.map(
		func(need): return int(inventory[need.id].amount / float(need.amount))
	)
	return available_amounts.min()


func reset() -> void:
	inventory = {}
	for id in gdata.items:
		var item = Item.new()
		item.init(id, gdata.items[id])
		inventory[id] = item

		if FeatureFlags.filled_inventory:
			item.amount = 5000


func _on_add_to_inventory(item_id: String, amount: int):
	inventory[item_id].amount += amount
	inventory[item_id].seen = true
	eventbus.inventory_changed.emit(item_id, inventory[item_id].amount)


func save() -> Dictionary:
	return {
		"is_autoload": true,
		"autoload_name": "GInventory",
		"inventory": inventory.values().map(func(item): return item.save()),
	}


func load_from(save_dict) -> void:
	reset()
	for item_save_data in save_dict.inventory:
		var id = item_save_data.id
		var base_data = gdata.get_item(id)
		var item = Item.new()
		item.init(id, base_data)
		item.load_from(item_save_data)
		inventory[id] = item

	loading_finished.emit()
