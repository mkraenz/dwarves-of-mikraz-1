extends RichTextLabel

var eventbus := Eventbus

@onready var timer: Timer = $Timer

var queue := []


# Called when the node enters the scene tree for the first time.
func _ready():
	text = ""
	eventbus.show_notification.connect(_on_show_notification)


func _on_show_notification(message: String, duration_in_sec: float) -> void:
	queue.append({"message": message, "duration_in_sec": duration_in_sec})
	if timer.is_stopped():
		display_notification()


func _on_timer_timeout():
	display_notification()


func display_notification() -> void:
	text = ""

	var next_notification = queue.pop_front()
	if next_notification:
		text = "[center]%s[/center]" % [next_notification.message]
		timer.start(next_notification.duration_in_sec)
