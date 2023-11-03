extends Node

## Todo #1 rename to crafting_recipes
var crafting: Dictionary
var items: Dictionary


func _ready():
	crafting = read_json_dict("res://assets/data/crafting.json")
	items = read_json_dict("res://assets/data/items.json")


func read_json_dict(filepath: String):
	var file = FileAccess.open(filepath, FileAccess.READ)
	var json = JSON.new()
	var error = json.parse(file.get_as_text())
	if error == OK:
		if typeof(json.data) == TYPE_DICTIONARY:
			return json.data
		else:
			prints("Unexpected data for filepath", filepath)
	else:
		prints(
			"JSON Parse Error:",
			json.get_error_message(),
			"for filepath",
			filepath,
			"at line",
			json.get_error_line()
		)
