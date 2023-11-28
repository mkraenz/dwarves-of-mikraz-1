extends Node

## @type {CraftingData}
var crafting_recipes: Dictionary
## @type {ItemData}
var items: Dictionary
## @type {BuildingData}
var buildings: Dictionary
var version: String = "0.0.x"
## @type {ScriptRegistry}
var scripts: Dictionary
## @type {ResourceNodeData}
var resource_nodes: Dictionary
## @type {Quests}
var quests: Dictionary


func _ready():
	crafting_recipes = read_json_dict("res://assets/data/crafting-recipes.json")
	items = read_json_dict("res://assets/data/items.json")
	buildings = read_json_dict("res://assets/data/buildings.json")
	version = read_json_dict("res://package.json").version
	scripts = read_json_dict("res://assets/data/script.registry.json")
	resource_nodes = read_json_dict("res://assets/data/resource-nodes.json")
	quests = read_json_dict("res://assets/data/quests.json")


func read_json_dict(filepath: String):
	var file = FileAccess.open(filepath, FileAccess.READ)
	var json = JSON.new()
	var error = json.parse(file.get_as_text())
	if error == OK:
		if typeof(json.data) == TYPE_DICTIONARY:
			return json.data
		else:
			push_warning("Unexpected data for filepath", filepath)
	else:
		push_warning(
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


func get_localized_item_label(id: String) -> String:
	var language = TranslationServer.get_locale().substr(0, 2)
	var label = items[id].label.get(language)
	if label:
		return label
	return items[id].label.en


func get_building(id: String) -> Dictionary:
	return buildings[id]


func get_building_icon(id: String) -> Texture2D:
	var building := get_building(id)
	return _load_icon(building.icon, id)


func _load_icon(icon: Dictionary, id: String) -> Texture2D:
	match icon.type:
		"Texture2D":
			var texture: CompressedTexture2D = load(icon.res_path)
			return texture
		"AtlasTexture":
			var underlying_texture: CompressedTexture2D = load(icon.res_path)
			var texture: AtlasTexture = AtlasTexture.new()
			texture.atlas = underlying_texture
			var region = icon.region
			texture.region = Rect2(region.x, region.y, region.width, region.height)
			return texture
		_:
			push_error("Unsupported texture type for ", id)
			return null


func get_resource_node(id: String) -> Dictionary:
	return resource_nodes[id]
