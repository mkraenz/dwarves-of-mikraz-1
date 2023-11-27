extends Control

var app_config := AppConfig


func close_menu() -> void:
	hide()
	app_config.persist()
