extends Node

@onready var eventbus := Eventbus
@onready var gstate := GState

var hits = 0


func _ready():
	eventbus.connect("hit_it", on_hit_it)
	eventbus.connect("hit_it_harder", on_hit_it_harder)


func on_hit_it() -> void:
	hits += 1
	check_win_condition()


func on_hit_it_harder() -> void:
	hits += 2
	check_win_condition()


func check_win_condition() -> void:
	match hits:
		0, 1, 2, 3, 4, 5, 6, 7, 8, 9:
			gstate.open_textbox("tv-after-hard-hit")
		10, _:
			gstate.open_textbox("tv-hitting-worked")


func reset() -> void:
	hits = 0
