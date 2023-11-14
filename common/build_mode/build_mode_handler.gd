extends Node2D

const Sawmill = preload("res://world/buildings/sawmill/sawmill.tscn")
const Smithy = preload("res://world/buildings/smithy/smithy.tscn")

var eventbus := Eventbus
var gstate := GState
var ginventory := GInventory
var gdata := GData

@onready var building_blueprint: Node2D = $BuildingBlueprint
@onready var click_delay := $InitialClickDelay
var building_id: String = ""

var blueprint: PhysicsBody2D
var colliding = true


func _ready():
	eventbus.enter_build_mode.connect(_on_enter_build_mode)
	eventbus.exit_build_mode.connect(_on_exit_build_mode)


func _physics_process(_delta):
	if blueprint:
		colliding = blueprint.test_move(blueprint.transform, Vector2.ZERO)
		if colliding:
			blueprint.modulate = Color.RED
		else:
			blueprint.modulate = Color.GREEN


func _input(_event) -> void:
	if gstate.mode == GState.Mode.build:
		blueprint.global_position = get_global_mouse_position()

		if Input.is_action_just_pressed("act") and click_delay.is_stopped() and not colliding:
			var building := gdata.get_building(building_id)
			if ginventory.satisfies_all_needs(building.needs):
				consume_resources(building.needs)
				var BuildingScene = get_building_scene()
				spawn_at_mouse_position(BuildingScene)
				eventbus.exit_build_mode.emit()
				eventbus.enter_character_mode.emit()


func spawn_at_mouse_position(Scene: PackedScene) -> void:
	var instance := Scene.instantiate()
	var pos := get_global_mouse_position()
	instance.global_position = pos
	get_parent().add_child(instance)


func _on_exit_build_mode() -> void:
	building_blueprint.hide()
	Utils.remove_all_children(building_blueprint)
	blueprint = null


func _on_enter_build_mode(_building_id: String) -> void:
	if blueprint:
		blueprint.queue_free()
	building_id = _building_id
	var Scene := get_building_scene()
	blueprint = Scene.instantiate()
	blueprint.collision_layer = 0
	building_blueprint.add_child(blueprint)
	building_blueprint.show()
	click_delay.start()


func get_building_scene() -> PackedScene:
	match building_id:
		"sawmill":
			return Sawmill
		"smithy":
			return Smithy
		"":
			printt(name, "ERROR! building_id is not initialized to an actual value.")
			return
		_:
			print(
				"actually selected %s, but so far we only have the Sawmill building" % building_id
			)
			return Sawmill


func consume_resources(needs: Array) -> void:
	for need in needs:
		eventbus.add_to_inventory.emit(need.id, -need.amount)
