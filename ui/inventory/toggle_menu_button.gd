extends Button

var eventbus := Eventbus


func _on_pressed():
	eventbus.toggle_inventory_menu.emit()
