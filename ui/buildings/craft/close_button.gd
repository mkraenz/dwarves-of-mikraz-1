extends Button

var eventbus := Eventbus


func _on_pressed():
	eventbus.close_crafting_menu.emit()
