extends ColorRect

var eventbus := Eventbus
@onready var anims: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	eventbus.scene_transition_hide.connect(_on_scene_transition_hide)
	eventbus.scene_transition_show.connect(_on_scene_transition_show)


func _on_scene_transition_hide() -> void:
	anims.play("transition_hide")
	await anims.animation_finished
	eventbus.scene_transition_finished.emit()


func _on_scene_transition_show() -> void:
	# TODO seems like we can do
	anims.play_backwards("transition_hide")
	# anims.play("transition_show")
	await anims.animation_finished
	eventbus.scene_transition_finished.emit()
