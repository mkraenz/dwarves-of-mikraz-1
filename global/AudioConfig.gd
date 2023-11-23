extends Node

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
