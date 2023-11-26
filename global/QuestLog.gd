extends Node2D

const Quest = preload("res://common/quest/quest.gd")

signal quest_completed(quest: Quest)
signal quest_started(quest: Quest)
signal quest_progress_updated(quest: Quest)
signal loading_finished

var ginventory := GInventory
var gdata := GData
var gstate := GState
var eventbus := Eventbus

## @type {Record<string, Quest>}
var quests := {}

## @type {Record<string, Quest>}
var started_quests := {}:
	get = _get_started_quests


func _get_started_quests() -> Dictionary:
	var started := {}
	for quest_id in quests:
		if quests[quest_id].started:
			started[quest_id] = quests[quest_id]
	return started


func _ready() -> void:
	reset()


func _physics_process(_delta: float) -> void:
	for quest_id in gdata.quests:
		var quest_data = gdata.quests[quest_id]
		var quest = quests[quest_id]

		if quest.completed:
			continue
		if not quest.started:
			continue

		quest.progress = quest_data.success_conditions.map(get_progress)
		quest_progress_updated.emit(quest)  # fixme optimization: only emit when sth actually changed

		var is_completed := (quest_data.success_conditions as Array).all(
			success_condition_fulfilled
		)
		if is_completed:
			quest.completed = true
			quest.quest_completed.emit()
			quest_completed.emit(quest)
			var completion_signal = quest.base_data.on_complete
			eventbus[completion_signal.signal].emit(completion_signal.signal_params)


func success_condition_fulfilled(condition: Dictionary):
	match condition.type:
		"collect item":
			return ginventory.satisfies_all_needs([condition.item])


func reset() -> void:
	for quest_id in gdata.quests:
		var quest = Quest.new()
		quest.init(quest_id, gdata.quests[quest_id])
		quests[quest_id] = quest


func get_progress(condition: Dictionary):
	match condition.type:
		"collect item":
			return {
				"current_amount": ginventory.get_item(condition.item.id).amount,
				"id": condition.item.id,
				"required_amount": condition.item.amount
			}


func start_quest(id: String) -> void:
	var quest = quests[id]
	quest.started = true
	quest_started.emit(quest)


func save() -> Dictionary:
	return {
		"is_autoload": true,
		"autoload_name": "QuestLog",
		"quests": quests.values().map(func(quest): return quest.save())
	}


func load_from(save_dict: Dictionary) -> void:
	reset()
	for quest_save_data in save_dict.quests as Array:
		var id = quest_save_data.id
		var quest_base_data = gdata.quests[id]
		var quest = Quest.from_save_data(quest_save_data, quest_base_data)
		quests[id] = quest
	loading_finished.emit()
