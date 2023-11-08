extends Node

## type: CraftingData
var crafting_recipes: Dictionary
## type: ItemData
var items: Dictionary
## type: BuildingData
var buildings: Dictionary


func _ready():
	crafting_recipes = read_json_dict("res://assets/data/crafting-recipes.json")
	items = read_json_dict("res://assets/data/items.json")
	buildings = read_json_dict("res://assets/data/buildings.json")


func read_json_dict(filepath: String):
	var file = FileAccess.open(filepath, FileAccess.READ)
	var json = JSON.new()
	var error = json.parse(file.get_as_text())
	if error == OK:
		if typeof(json.data) == TYPE_DICTIONARY:
			return json.data
		else:
			printt("Unexpected data for filepath", filepath)
	else:
		printt(
			"JSON Parse Error:",
			json.get_error_message(),
			"for filepath",
			filepath,
			"at line",
			json.get_error_line()
		)


func get_item_icon(id: String) -> Texture2D:
	var item := get_item(id)
	return _load_icon(item.icon, id)


func get_item(id: String) -> Dictionary:
	return items[id]


func get_building(id: String) -> Dictionary:
	return buildings[id]


func get_building_icon(id: String) -> Texture2D:
	var building := get_building(id)
	return _load_icon(building.icon, id)


func _load_icon(icon: Dictionary, id: String) -> Texture2D:
	match icon.type:
		"Texture2D":
			var texture: CompressedTexture2D = load(icon.resPath)
			return texture
		"AtlasTexture":
			return null
		_:
			printt("ERROR: unsupported texture type for ", id)
			return null
