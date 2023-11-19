extends Control


func _ready() -> void:
	if not FeatureFlags.debug:
		hide()
