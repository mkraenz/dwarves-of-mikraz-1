extends Node

var bodies_in_player_action_radius: Array = []
var is_ingame := false:
	get = _get_is_ingame

var cam: Camera2D = null:
	get = _get_cam

## in seconds
var tick_duration: float = 1


func _get_cam() -> Camera2D:
	return get_node("/root/Main/World/Cam")


func _get_is_ingame() -> bool:
	var main = get_node("/root/Main")
	if not main:
		return false
	return main.is_ingame()


func reset() -> void:
	bodies_in_player_action_radius.clear()


## performance optimization: if this gets called on every frame, it might be worth to instead sort bodies_in_player_action_radius on every insert/delete
func get_closest_body_in_player_action_radius(to_global_position: Vector2) -> Variant:
	return get_closest_node(to_global_position, bodies_in_player_action_radius)


func get_closest_node(to_global_position: Vector2, nodes: Array[Variant]) -> Variant:
	if len(nodes) == 0:
		return null
	if len(nodes) == 1:
		return nodes[0]

	var min_node = nodes[0]
	var min_dist = to_global_position.distance_to(min_node.global_position)
	for node in nodes:
		var dist = to_global_position.distance_to(node.global_position)
		if dist < min_dist:
			min_node = node
			min_dist = dist
	return min_node
