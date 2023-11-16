extends Node

var inventory := GInventory
var gstate := GState
var gdata := GData

## largely following https://docs.godotengine.org/en/stable/tutorials/io/saving_games.html

# remove savegame command on my ubuntu: rm ~/.local/share/godot/app_userdata/Dwarves\ of\ Mikraz\ 1/savegame.save
const FILEPATH = "user://savegame.save"


func save_game_exists() -> bool:
	return FileAccess.file_exists(FILEPATH)


func save_game(tree: SceneTree):
	var save_file = FileAccess.open(FILEPATH, FileAccess.WRITE)
	var save_nodes = tree.get_nodes_in_group("persist")
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.scene_file_path.is_empty():
			push_warning("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			push_warning("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		var node_data = node.call("save")
		var json_string = JSON.stringify(node_data)
		save_file.store_line(json_string)

	for global_variable in [inventory]:
		var node_data = global_variable.call("save")
		var json_string = JSON.stringify(node_data)
		save_file.store_line(json_string)


## Note: This can be called from anywhere inside the tree. This function
## is path independent.
## get_tree_node is used for injecting `get_node` from a node within
## the tree into this function. Not doing so will cause an error.
## Alternative would be to have like a /root/Main/Scripts/Persistence node with this script,
## so that get_tree() and get_node() have the tree context set.
func load_game(tree: SceneTree, get_tree_node: Callable):
	if not FileAccess.file_exists(FILEPATH):
		return  # Error! We don't have a save to load.

	# We need to revert the game state so we're not cloning objects
	# during loading. This will vary wildly depending on the needs of a
	# project, so take care with this step.
	# For our example, we will accomplish this by deleting saveable objects.
	var save_nodes = tree.get_nodes_in_group("persist")
	for key in save_nodes:
		key.queue_free()

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_file = FileAccess.open(FILEPATH, FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			push_warning(
				"JSON Parse Error: ",
				json.get_error_message(),
				" in ",
				json_string,
				" at line ",
				json.get_error_line()
			)
			continue

		var node_data = json.get_data()

		if node_data.get("is_autoload"):
			if node_data["autoload_name"] == "GInventory":
				inventory.inventory = node_data["inventory"]
		else:
			const handled_keys = ["file_id", "parent", "pos_x", "pos_y", "is_autoload", "node_name"]

			# Firstly, create the object and set its position.
			var script = gdata.scripts.get(node_data["file_id"])
			if not script:
				push_error(
					(
						"Script found in save game that does not exist in the script registry. file_id: %s"
						% node_data["file_id"]
					)
				)
			var new_object = load(script.res_path).instantiate()
			new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])

			# Now we set the remaining variables.
			for key in node_data.keys():
				if handled_keys.has(key):
					continue
				var val = node_data[key]
				match typeof(val):
					TYPE_STRING:
						var value = JSONX.try_parse_infinity(val)
						new_object.set(key, value)
					_:
						new_object.set(key, val)

			# finally add to tree. This happens last so that _ready is not called before all the properties have been re-initialized
			get_tree_node.call(node_data["parent"]).add_child(new_object)

			if new_object.has_method("on_load"):
				new_object.on_load(node_data)

			if "node_name" in node_data and node_data["node_name"] == "Player":
				new_object.connect_camera(gstate.cam)
