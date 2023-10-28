extends Sprite2D

@export var min_y: int = -2
@export var max_y: int = 2
@export var timeout: float = 0.15
## 1 or -1
@export var dir: int = +1

@onready var timer: Timer = $Timer


func _ready():
	timer.start(timeout)


func _on_timer_timeout():
	if dir == 1:
		if position.y + 1 > max_y:
			dir = -1
	else:
		if position.y - 1 < min_y:
			dir = 1
	position.y += dir
