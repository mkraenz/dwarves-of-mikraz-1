extends Control

const OptionsRow = preload("res://ui/textbox/option_row.tscn")

@export var CHAR_READ_RATE = 0.045

@onready var gstate := GState
@onready var eventbus := Eventbus

@onready var options := $ScreenMargin/Padding/V/Options
@onready var label := $ScreenMargin/Padding/V/Label

var tween: Tween

var selected_option_index = 0:
	set = _set_selected_option_index


func _set_selected_option_index(value: int) -> void:
	var children = options.get_children()
	if children.size() == 0:
		return
	children[selected_option_index].unselect()
	selected_option_index = value % children.size()
	children[selected_option_index].select()


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	eventbus.connect("show_textbox", handle_show)
	eventbus.connect("close_textbox", close)


func _unhandled_input(event):
	if not gstate.textbox_open:
		return  # input handling should be on player if textbox is closed

	if Input.is_action_just_pressed("close"):
		close()

	if Input.is_action_just_pressed("move_down"):
		selected_option_index += 1

	if Input.is_action_just_pressed("move_up"):
		selected_option_index -= 1

	if Input.is_action_just_pressed("confirm"):
		confirm_selection()

	if event is InputEventKey:
		if Input.is_anything_pressed() and event.keycode in range(KEY_0, KEY_9):
			selected_option_index = event.keycode - KEY_0
			confirm_selection()


func confirm_selection() -> void:
	var children = options.get_children()
	prints("selected_option_index", selected_option_index)
	children[selected_option_index].confirm()


func handle_show(label_and_options: Dictionary) -> void:
	clear_options()

	label.text = label_and_options["label"]

	var quit_options_row = make_options_row(
		{"label": "Leave", "event_name_on_selected": "close_textbox"}, 0
	)
	options.add_child(quit_options_row)

	for i in label_and_options["options"].size():
		var option: Dictionary = label_and_options["options"][i]
		var option_row := make_options_row(option, i + 1)
		options.add_child(option_row)

	options.hide()
	animate_text()
	show()

	get_viewport().set_input_as_handled()  # without this the move_up input handler in _unhandled_input(..) will be triggered and cause the cursor to move up immediately on walking into the object


func animate_text() -> void:
	if tween:
		tween.kill()  # Abort the previous animation.
	tween = create_tween()
	label.visible_characters = 0
	(
		tween
		. tween_property(
			label,
			"visible_characters",
			len(label.text),
			len(label.text) * CHAR_READ_RATE,
		)
	)
	tween.tween_callback(func(): options.show())


func clear_options() -> void:
	selected_option_index = 0
	for child in options.get_children():
		child.queue_free()


func make_options_row(option: Dictionary, ordinal: int) -> Control:
	var options_row = OptionsRow.instantiate()
	options_row.option_text = option.label
	options_row.ordinal = ordinal
	options_row.on_confirm = func(): eventbus.emit_signal(option.event_name_on_selected)
	if ordinal == 0:
		options_row.selected = true
	return options_row


func close() -> void:
	hide()
	eventbus.textbox_hidden.emit()
