extends Button

var eventbus := Eventbus


func _on_pressed() -> void:
	eventbus.toggle_options_menu.emit()
