extends Area2D

@export var reference_node: Node2D

@onready var gstate := GState


func _physics_process(_delta: float):
	# if two interactable or mineable objects are within radius and we move between then, we want the mark to move to the closest one. So we need to do this on every movement
	unmark_all()
	add_marks()


func _on_body_entered(body: Node2D):
	if body not in gstate.bodies_in_player_action_radius:
		gstate.bodies_in_player_action_radius.append(body)


func _on_body_exited(body: Node2D):
	gstate.bodies_in_player_action_radius.erase(body)

	if body.has_node("Marker"):
		body.get_node("Marker").unmark()


func unmark_all() -> void:
	for node in gstate.bodies_in_player_action_radius:
		if node.has_node("Marker"):
			node.get_node("Marker").unmark()


func add_marks() -> void:
	var closest_interactable = gstate.get_closest_body_in_player_action_radius(
		reference_node.global_position, "interact"
	)
	try_mark_node(closest_interactable)

	var closest_mineable = gstate.get_closest_body_in_player_action_radius(
		reference_node.global_position, "mine"
	)
	try_mark_node(closest_mineable)


func act_on_closest_actable(method_name: String):
	var closest_node = gstate.get_closest_body_in_player_action_radius(
		reference_node.global_position, method_name
	)
	if closest_node:
		closest_node.call(method_name)


func try_mark_node(node: Node2D):
	if node and node.has_node("Marker"):
		node.get_node("Marker").mark()
