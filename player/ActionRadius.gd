extends Area2D

@onready var gstate := GState


func _on_body_entered(body: Node2D):
	if body is PhysicsBody2D and body not in gstate.bodies_in_player_action_radius:
		gstate.bodies_in_player_action_radius.append(body)
		refresh_marks()


func _on_body_exited(body: Node2D):
	# order is important: first remove mark, then erase body
	refresh_marks(body)
	gstate.bodies_in_player_action_radius.erase(body)


func refresh_marks(removed_body = null) -> void:
	var player = get_parent()
	for node in gstate.bodies_in_player_action_radius:
		if node.has_method("unmark"):
			node.unmark()

	var closest = gstate.get_closest_body_in_player_action_radius(player.global_position)
	if closest and removed_body != closest and closest.has_method("mark"):
		closest.mark()
		print("marked closest node", closest)
