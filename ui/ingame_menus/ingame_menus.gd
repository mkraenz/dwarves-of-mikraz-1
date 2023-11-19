extends Control


func hide_children():
	for child in get_children():
		child.hide()
	show()
