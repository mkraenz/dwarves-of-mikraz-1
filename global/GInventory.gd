extends Node

var eventbus := Eventbus
var gdata := GData

## type: { [item_id: string]: {amount: int} }
var inventory: Dictionary


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
		inventory[key] = {"amount": 0}


func _on_add_to_inventory(item_id: String, amount: int):
	inventory[item_id].amount += amount
	eventbus.inventory_changed.emit(item_id, inventory[item_id].amount)


func save():
	var data = {
		## TODO a direct dependency on the file path (in save file: `"filename":"res://player/Player.tscn"`) means that we cannot move or rename the file. Idea: better to have an ID to a file here, as well as a lookup table (in code only!) that is easily changeable. Same goes for autoload_name actually
		"filename": get_scene_file_path(),
		"is_autoload": true,
		"autoload_name": "GInventory",
		"inventory": inventory
	}
	return data
