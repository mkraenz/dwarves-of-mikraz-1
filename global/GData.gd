extends Node

var crafting_recipes: Dictionary
var items: Dictionary


func _ready():
	crafting_recipes = read_json_dict("res://assets/data/crafting-recipes.json")
	items = read_json_dict("res://assets/data/items.json")


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


func get_item_icon(item_id: String) -> Texture2D:
	var item: Dictionary = items[item_id]
	match item.icon.type:
		"Texture2D":
			var texture: CompressedTexture2D = load(item.icon.resPath)
			return texture
		"AtlasTexture":
			return null
		_:
			printt("ERROR: unsupported texture type for ", item_id)
			return null


func get_item(id: String) -> Dictionary:
	return items[id]
