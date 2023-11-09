extends Node

var eventbus := Eventbus
var gdata := GData

## human-readable item_id to Item
var inventory: Dictionary


func _ready():
	reset()
	eventbus.add_to_inventory.connect(_on_add_to_inventory)


func has(item_id: String, amount: int) -> bool:
	return inventory[item_id].amount >= amount


func get_max_producable_batches(needs: Array) -> float:
	var available_amounts = needs.map(
		func(need): return int(inventory[need.id].amount / float(need.amount))
	)
	return available_amounts.min()


func reset() -> void:
	inventory = {}
	for key in gdata.items:
		inventory[key] = {"amount": 0}


func _on_add_to_inventory(resource_name: String, amount: int):
	inventory[resource_name].amount += amount


func save():
	var data = {
		## TODO a direct dependency on the file path (in save file: `"filename":"res://player/Player.tscn"`) means that we cannot move or rename the file. Idea: better to have an ID to a file here, as well as a lookup table (in code only!) that is easily changeable. Same goes for autoload_name actually
		"filename": get_scene_file_path(),
		"is_autoload": true,
		"autoload_name": "GInventory",
		"inventory": inventory
	}
	return data
