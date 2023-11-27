extends HBoxContainer

@export var bus_name := ""

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
	AudioConfig.set_volume(bus_name, value)
	update_view()
