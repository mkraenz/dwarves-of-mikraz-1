extends Button

var eventbus := Eventbus


func _on_pressed():
	eventbus.toggle_building_menu.emit()
