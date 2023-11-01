extends Node

var eventbus := Eventbus

## human-readable item_id to Item
var inventory: Dictionary


func _ready():
	reset()
	eventbus.add_to_inventory.connect(_on_add_to_inventory)


func reset() -> void:
	inventory = {
		"log": {"amount": 0, "label": "Log"},
		"plank": {"amount": 0, "label": "Plank"},
		"stone": {"amount": 0, "label": "Stone"},
		"iron": {"amount": 0, "label": "Iron ore"}
	}


func _on_add_to_inventory(resource_name: String, amount: int):
	inventory[resource_name].amount += amount


func save():
	var data = {
		"filename": get_scene_file_path(),
		"is_autoload": true,
		"autoload_name": "GInventory",
		"inventory": inventory
	}
	return data
