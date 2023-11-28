extends VBoxContainer

const QuestLogEntryNeededItem = preload(
	"res://ui/hud/quest_log/quest_log_entry/quest_log_entry_needed_item.tscn"
)

@export var quest: Quest

var gdata := GData
@onready var teaser := $Teaser

## @type {QuestLogEntryNeededItem[]}
var need_item_labels := []


func _ready():
	quest.progress_updated.connect(_on_progress_updated)
	quest.quest_completed.connect(_on_quest_completed)
	teaser.text = quest.base_data.teaser
	for need in quest.progress:
		var label = QuestLogEntryNeededItem.instantiate()
		label.text = "· {current_amount}/{required_amount} {item_name}".format(
			{
				"current_amount": need.current_amount,
				"required_amount": need.required_amount,
				"item_name": gdata.get_localized_item_label(need.id)
			}
		)
		add_child(label)
		need_item_labels.append(label)


func _on_progress_updated() -> void:
	if not need_item_labels:
		for need in quest.progress:
			var label = QuestLogEntryNeededItem.instantiate()
			add_child(label)
			need_item_labels.append(label)

	for i in len(quest.progress):
		var label = need_item_labels[i]
		var need = quest.progress[i]
		label.text = "· {current_amount}/{required_amount} {item_name}".format(
			{
				"current_amount": need.current_amount,
				"required_amount": need.required_amount,
				"item_name": gdata.get_localized_item_label(need.id)
			}
		)


func _on_quest_completed() -> void:
	for i in len(quest.progress):
		var label = need_item_labels[i]
		var need = quest.progress[i]
		label.text = "~~~~~~· {current_amount}/{required_amount} {item_name}".format(
			{
				"current_amount": need.current_amount,
				"required_amount": need.required_amount,
				"item_name": gdata.get_localized_item_label(need.id)
			}
		)
