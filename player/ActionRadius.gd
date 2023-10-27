extends Area2D

var entered_bodies: Array = []


func _on_body_exited(body: Node2D):
	if not body in entered_bodies:
		print(body)
		entered_bodies.append(body)


func _on_body_entered(body: Node2D):
	entered_bodies.erase(body)
