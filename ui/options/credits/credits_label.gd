extends RichTextLabel


func _ready() -> void:
	var file = FileAccess.open("res://ui/options/credits/credits.bbcode.txt", FileAccess.READ)
	var content = file.get_as_text()
	text = content
