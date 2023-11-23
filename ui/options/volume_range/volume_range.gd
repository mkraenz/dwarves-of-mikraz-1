extends HBoxContainer

signal volume_changed(new_val: float)

@export var bus_name := ""

const display_max_value := 10
const display_min_value := 0
const min_volume_db := -30.0

@onready var config = AudioConfig

@onready var bus = config.audio_buses[bus_name]
@onready var initial_volume = config.initial_volumes[bus_name]
@onready var display_value = config.current_volume_views[bus_name]

@onready var slider := $VolumeSlider


func _ready() -> void:
	update_view()


func update_view() -> void:
	slider.value = config.current_volume_views[bus_name]


func reset() -> void:
	AudioServer.set_bus_volume_db(bus, initial_volume)
	update_view()


func _on_volume_slider_value_changed(value: float) -> void:
	display_value = int(value)
	var volume = lerp(
		initial_volume,
		min_volume_db,
		(display_max_value - value) / (display_max_value - display_min_value)
	)  # remember, 10 means -0db, 1=-30db * 0.9

	config.current_volume_views[bus_name] = display_value

	if value == 0.0:
		AudioServer.set_bus_mute(bus, true)
	else:
		AudioServer.set_bus_mute(bus, false)
		AudioServer.set_bus_volume_db(bus, volume)

	update_view()
