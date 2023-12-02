extends VBoxContainer

const QuestLogEntry = preload("res://ui/hud/quest_log/quest_log_entry/quest_log_entry.tscn")

var gstate := GState

var active_quests = []


func _ready() -> void:
	QuestLog.quest_started.connect(_on_quest_started)
	QuestLog.quest_completed.connect(_on_quest_completed)
	QuestLog.loading_finished.connect(reset)
	QuestLog.reset_finished.connect(reset)

	init_entries()


func _on_quest_started(quest: Quest) -> void:
	active_quests.append(quest)

	var entry = QuestLogEntry.instantiate()
	entry.quest = quest
	add_child(entry)


func _on_quest_completed(quest: Quest) -> void:
	active_quests.erase(quest)


func init_entries() -> void:
	for quest_id in QuestLog.started_quests:
		var quest = QuestLog.started_quests[quest_id]
		var entry = QuestLogEntry.instantiate()
		entry.quest = quest
		add_child(entry)


func reset() -> void:
	Utils.remove_all_children(self)
	init_entries()
