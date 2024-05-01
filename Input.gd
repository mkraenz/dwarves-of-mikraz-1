extends LineEdit


func _ready():
	grab_focus()


func _on_text_changed(new_text: String) -> void:
	text = new_text.to_upper()
	set_caret_column(len(text))  # not sure why but setting text to uppercase sets the caret to beginning of the line
