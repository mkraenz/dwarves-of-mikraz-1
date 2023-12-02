extends Node

const AudioConfig = preload("res://global/AudioConfig.gd")

## All kinds of configs that are relevant for the application (as opposed to a specific game setting) like audio, language, graphics, etc. Loaded on application startup.

const FILEPATH = "user://config.json"

var eventbus := Eventbus

var audio: AudioConfig = AudioConfig.new()


func config_file_exists() -> bool:
	return FileAccess.file_exists(FILEPATH)


func _ready() -> void:
	if not config_file_exists():
		handle_first_open()
		return

	var save_dict = load_from_disc()
	if not save_dict:
		handle_first_open()
		return
	load_from(save_dict)


func handle_first_open() -> void:
	var initial_locale = OS.get_locale().substr(0, 5)
	change_locale(initial_locale)  # this one is not working for UI, but TranslationServer.get_locale() inside persist and other components already can use that value
	call_deferred("change_locale", initial_locale)  # this actually applies the locale to the current game
	persist()


func change_locale(locale: String):
	TranslationServer.set_locale(locale)
	eventbus.locale_changed.emit()


func persist() -> void:
	var save_dict = save()
	save_to_disc(save_dict)


func save() -> Dictionary:
	return {
		"is_autoload": true,
		"autoload_name": "AppConfig",
		"audio": audio.save(),
		"locale": TranslationServer.get_locale()
	}


func load_from(save_dict: Dictionary) -> void:
	audio.load_from(save_dict.audio)

	change_locale(save_dict.locale)  # this one is not working for UI, but TranslationServer.get_locale() inside persist and other components already can use that value
	# WORKAROUND: for whatever reason, changing the locale immediately doesn't it apply it to the scenes.
	call_deferred("change_locale", save_dict.locale)


func save_to_disc(save_dict: Dictionary):
	var save_file = FileAccess.open(FILEPATH, FileAccess.WRITE)
	var json_string = JSON.stringify(save_dict)
	save_file.store_line(json_string)


func read_json_dict(filepath: String):
	var file = FileAccess.open(filepath, FileAccess.READ)
	var json = JSON.new()
	var error = json.parse(file.get_as_text())
	if error == OK:
		if typeof(json.data) == TYPE_DICTIONARY:
			return json.data
		else:
			push_warning("Unexpected data for filepath", filepath)
	else:
		push_warning(
			"JSON Parse Error:",
			json.get_error_message(),
			"for filepath",
			filepath,
			"at line",
			json.get_error_line()
		)


## @return {dict | null}
func load_from_disc():
	return read_json_dict(FILEPATH)
