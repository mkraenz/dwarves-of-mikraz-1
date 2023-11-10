extends Area2D

@onready var gstate := GState


func _physics_process(delta):
	# if two crates are within radius and we move between then, we want the mark to move to the closest one. So we need to do this on every movement
	unmark_all()
	add_marks()


func _on_body_entered(body: Node2D):
	if body not in gstate.bodies_in_player_action_radius:
		gstate.bodies_in_player_action_radius.append(body)


func _on_body_exited(body: Node2D):
	gstate.bodies_in_player_action_radius.erase(body)


func unmark_all() -> void:
	for node in gstate.bodies_in_player_action_radius:
		if node.has_method("unmark"):
			node.unmark()


func add_marks() -> void:
	var player = get_parent()
	var closest_interactable = gstate.get_closest_body_in_player_action_radius(
		player.global_position, "interact"
	)
	try_mark_node(closest_interactable)

	var closest_mineable = gstate.get_closest_body_in_player_action_radius(
		player.global_position, "mine"
	)
	try_mark_node(closest_mineable)


func act_on_closest_actable(method_name: String):
	var player = get_parent()
	var closest_node = gstate.get_closest_body_in_player_action_radius(
		player.global_position, method_name
	)
	if closest_node:
		closest_node.call(method_name)


func try_mark_node(node: Node2D):
	if node and node.has_method("mark"):
		node.mark()
