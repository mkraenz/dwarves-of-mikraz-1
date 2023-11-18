extends Node

var bodies_in_player_action_radius: Array = []
var is_ingame := false:
	get = _get_is_ingame

enum Mode { menu, build, character }
var mode: Mode = Mode.menu

## camera sets itself on ready
var cam: Camera2D
var level: Node2D

## in seconds
var tick_duration: float = 1

var player_input_blocked = true:
	get = _get_player_input_blocked


func _get_player_input_blocked() -> bool:
	var nodes = get_tree().get_nodes_in_group("blocking")
	var some_blocking_node_visible = nodes.any(func(x): return x.visible)
	return some_blocking_node_visible


func _get_is_ingame() -> bool:
	var main = get_node("/root/Main")
	if not main:
		return false
	return main.is_ingame()


func reset() -> void:
	bodies_in_player_action_radius.clear()
	mode = Mode.menu


## performance optimization: if this gets called by many clients on every frame, it might be worth to instead sort bodies_in_player_action_radius on every frame. We would then just need to take the first array element (if no filter), or the first element in order that also has the method (if with filter)
func get_closest_body_in_player_action_radius(
	to_global_position: Vector2, filter_by_method_name: String = ""
) -> Variant:
	if filter_by_method_name:
		var is_methodable = func(x: Node2D): return x.has_method(filter_by_method_name)
		var nodes_in_reach = bodies_in_player_action_radius.filter(is_methodable)
		return get_closest_node(to_global_position, nodes_in_reach)

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
