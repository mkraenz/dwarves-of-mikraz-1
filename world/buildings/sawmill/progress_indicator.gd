extends Sprite2D

## mostly following https://docs.godotengine.org/en/latest/tutorials/2d/custom_drawing_in_2d.html
## NOTE: Texture progress bar has all of this built-in, so maybe switch to that at some point.

@export var center := Vector2(0, 0)
@export var radius: float = 10
@export var color := Color(1.0, 0.0, 0.0)

var enabled := false:
	set = _set_enabled

## duration in seconds
var duration: float = 1:
	set = _set_duration

## in degrees per second
var _angular_velocity: float = 1
var angle_from: float = 0
var angle_to: float = 1


func _ready():
	enabled = false  # necessary to re-initialize to the default value due to the code in the setter


func _physics_process(delta):
	angle_to += _angular_velocity * delta
	if angle_to > 360:
		angle_to = wrapf(angle_to, 0, 360)
		stop()
	queue_redraw()


func _draw():
	_draw_circle_arc_poly(center, radius, angle_from, angle_to, color)


func _draw_circle_arc_poly(
	_center: Vector2, _radius: float, _angle_from: float, _angle_to: float, _color: Color
):
	var nb_points = 32
	var points_arc = PackedVector2Array()
	points_arc.push_back(_center)
	var colors = PackedColorArray([_color])

	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(_angle_from + i * (_angle_to - _angle_from) / nb_points - 90)
		points_arc.push_back(_center + Vector2(cos(angle_point), sin(angle_point)) * _radius)
	draw_polygon(points_arc, colors)


func _set_enabled(val: bool) -> void:
	enabled = val
	set_physics_process(enabled)


func _set_duration(val: float) -> void:
	duration = val
	_angular_velocity = 360 / duration


## Restarts the current progress
func start(duration_in_sec: float):
	enabled = true
	duration = duration_in_sec
	angle_to = 0
	show()


func stop():
	enabled = false
	hide()
