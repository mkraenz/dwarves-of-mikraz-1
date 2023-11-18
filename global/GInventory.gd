extends Node

var eventbus := Eventbus
var gdata := GData

## type:
## ```ts
## {
##	[item_id: string]: {
##		amount: int;
## 		/** whether the player has collected this resource before */
## 		seen: boolean
## 	}
## }
## ```
var inventory: Dictionary:
	set = _set_inventory

var seen_items: Dictionary:
	get = _get_seen_items


func _get_seen_items() -> Dictionary:
	var x_seen_items := {}
	for id in inventory.keys():
		var item = inventory[id]
		if item.seen:
			x_seen_items[id] = item
	return x_seen_items


func _set_inventory(val: Dictionary) -> void:
	inventory = {}
	for key in gdata.items:
		inventory[key] = {"amount": 0, "seen": false}
	# for backwards compatibility with old save states
	for key in val:
		if val[key].get("amount") != null:
			inventory[key].amount = val[key].get("amount")
		inventory[key].seen = (
			val[key].get("seen") if val[key].get("seen") else inventory[key].amount > 0
		)

	eventbus.ginventory_overwritten.emit()


func _ready():
	reset()
	eventbus.add_to_inventory.connect(_on_add_to_inventory)


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
	for key in gdata.items:
		inventory[key] = {"amount": 0, "seen": false}


func _on_add_to_inventory(item_id: String, amount: int):
	inventory[item_id].amount += amount
	inventory[item_id].seen = true
	eventbus.inventory_changed.emit(item_id, inventory[item_id].amount)


func save() -> Dictionary:
	var data = {
		"file_id": "ginventory_GVwfHU",
		"is_autoload": true,
		"autoload_name": "GInventory",
		"inventory": inventory
	}
	return data
