extends Node

@onready var words: Control = $Gui/Hud/Words
@onready var input: LineEdit = %Input
@onready var spawn_timer: Timer = $Timer

var points := 0

## @type {[word: string]: Node}
var current_words: Dictionary = {}


func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	spawn_timer.connect("timeout", _on_spawner_timeout)


## WARNING: NOT GUARANTEED TO FINISH!!!
func get_random_unused_word() -> String:
	var word = WordsData.WORD_POOL.pick_random()
	if word in current_words:
		return get_random_unused_word()
	return word


func _on_spawner_timeout() -> void:
	if len(current_words) > 100:
		return  # don't have too many words on screen
	var label := Label.new()
	label.text = get_random_unused_word()
	# TODO avoid the text input
	label.position.x = randi_range(0, 300)
	label.position.y = randi_range(0, 200)
	words.add_child(label)
	current_words[label.text] = label


func _on_input_text_changed(new_text: String) -> void:
	var key := new_text.to_upper()
	var label = current_words.get(key)
	if is_instance_valid(label):  # avoid null pointer + calling queue_free on already freed instance
		label.queue_free()
		points += 1
		input.call_deferred("clear")  # deferred in order to let the last uppercasing inside the input do it's work
		current_words.erase(key)
		printt("Points", points)
