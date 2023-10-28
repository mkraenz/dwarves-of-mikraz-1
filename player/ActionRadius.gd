extends Area2D

@onready var gstate := GState


func _on_body_entered(body: Node2D):
	if body is PhysicsBody2D and body not in gstate.bodies_in_player_action_radius:
		gstate.bodies_in_player_action_radius.append(body)


func _on_body_exited(body: Node2D):
	gstate.bodies_in_player_action_radius.erase(body)
