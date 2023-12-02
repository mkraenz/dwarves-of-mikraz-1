extends Node

const display_max_value := 10
const display_min_value := 0
const min_volume_db := -30.0

const INITIAL_VOLUME = 7

var audio_buses = {
	"Master": AudioServer.get_bus_index("Master"),
	"Sounds": AudioServer.get_bus_index("Sounds"),
	"Music": AudioServer.get_bus_index("Music"),
}
var initial_volumes = {
	"Master": AudioServer.get_bus_volume_db(audio_buses["Master"]),
	"Sounds": AudioServer.get_bus_volume_db(audio_buses["Sounds"]),
	"Music": AudioServer.get_bus_volume_db(audio_buses["Music"]),
}
var current_volume_views = {
	"Master": INITIAL_VOLUME,
	"Sounds": INITIAL_VOLUME,
	"Music": INITIAL_VOLUME,
}


func reset() -> void:
	current_volume_views = {
		"Master": INITIAL_VOLUME,
		"Sounds": INITIAL_VOLUME,
		"Music": INITIAL_VOLUME,
	}


func save() -> Dictionary:
	return {
		"master_volume": current_volume_views.Master,
		"sounds_volume": current_volume_views.Sounds,
		"music_volume": current_volume_views.Music,
	}


func load_from(save_dict: Dictionary) -> void:
	set_volume("Master", float(save_dict["master_volume"]))
	set_volume("Sounds", float(save_dict["sounds_volume"]))
	set_volume("Music", float(save_dict["music_volume"]))


func set_volume(bus_name: String, value: float) -> void:
	var display_value = int(value)

	var bus = audio_buses[bus_name]
	var initial_volume = initial_volumes[bus_name]
	var volume = lerp(
		initial_volume,
		min_volume_db,
		(display_max_value - value) / (display_max_value - display_min_value)
	)  # remember, 10 means -0db, 1=-30db * 0.9

	current_volume_views[bus_name] = display_value

	if value == 0.0:
		AudioServer.set_bus_mute(bus, true)
	else:
		AudioServer.set_bus_mute(bus, false)
		AudioServer.set_bus_volume_db(bus, volume)
