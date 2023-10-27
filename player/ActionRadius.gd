extends Area2D

var entered_bodies: Array = []


func _on_body_entered(body: Node2D):
	if body is PhysicsBody2D and body not in entered_bodies:
		entered_bodies.append(body)


func _on_body_exited(body: Node2D):
	entered_bodies.erase(body)
