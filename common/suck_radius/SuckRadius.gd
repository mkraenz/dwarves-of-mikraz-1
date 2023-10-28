extends Area2D

var sucked_objects = []


func _process(_delta) -> void:
	for object in sucked_objects:
		object.get_sucked_towards_global_pos = global_position


func _on_area_entered(area: Area2D) -> void:
	print("entered", area)
	if area not in sucked_objects:
		sucked_objects.append(area)


func _on_area_exited(area: Area2D) -> void:
	print("exited", area)
	if area.has_method("unsuck"):
		area.unsuck()
	sucked_objects.erase(area)
