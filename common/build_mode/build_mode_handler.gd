extends Node2D

const Sawmill = preload("res://world/buildings/sawmill/sawmill.tscn")
const CharcoalKiln = preload("res://world/buildings/charcoal_kiln/charcoal_kiln.tscn")
const Smithy = preload("res://world/buildings/smithy/smithy.tscn")
const Smelter = preload("res://world/buildings/smelter/smelter.tscn")

## The node that new buildings get attached to, and buildings attach outputs to.
@export var target_node: Node2D
@export var blueprint_collision_shape_scale := 1.45:
	set = _blueprint_collision_shape_scale

var eventbus := Eventbus
var gstate := GState
var ginventory := GInventory
var gdata := GData

@onready var blueprint_slot: Node2D = $BlueprintSlot
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
		if Input.is_action_just_pressed("close"):
			eventbus.exit_build_mode.emit()
			return

		if not blueprint:
			return

		blueprint.global_position = get_global_mouse_position()

		if Input.is_action_just_pressed("act") and click_delay.is_stopped() and not colliding:
			var building := gdata.get_building(building_id)
			if ginventory.satisfies_all_needs(building.needs):
				consume_resources(building.needs)
				var BuildingScene = get_building_scene()
				spawn_at_mouse_position(BuildingScene)
				if not Input.is_action_pressed("multiplace"):
					eventbus.exit_build_mode.emit()
			else:
				eventbus.show_notification.emit("Not enough resources.", 5.0)


func spawn_at_mouse_position(Scene: PackedScene) -> void:
	var instance := Scene.instantiate()
	var pos := get_global_mouse_position()
	instance.global_position = pos
	gstate.level.add_child(instance)


func _on_exit_build_mode() -> void:
	Utils.remove_all_children(blueprint_slot)
	blueprint = null


func _on_enter_build_mode(_building_id: String) -> void:
	if blueprint:
		blueprint.queue_free()
	building_id = _building_id
	var Scene := get_building_scene()
	blueprint = Scene.instantiate()
	blueprint.collision_layer = 0  # avoid pushing away objects with the blueprint
	blueprint.global_position = get_global_mouse_position()
	blueprint_slot.add_child(blueprint)
	scale_blueprint_collision_shape(blueprint_collision_shape_scale)
	click_delay.start()


## TODO can we automate this and instead use the script id to get the building from buildings.ts
func get_building_scene() -> PackedScene:
	match building_id:
		"sawmill":
			return Sawmill
		"smithy":
			return Smithy
		"charcoal_kiln":
			return CharcoalKiln
		"smelter":
			return Smelter
		"":
			push_error("building_id is not initialized to an actual value.")
			return
		_:
			push_error(
				"actually selected %s, but so far we only have the Sawmill building" % building_id
			)
			return Sawmill


func consume_resources(needs: Array) -> void:
	for need in needs:
		eventbus.add_to_inventory.emit(need.id, -need.amount)


func _blueprint_collision_shape_scale(val: float) -> void:
	blueprint_collision_shape_scale = val
	scale_blueprint_collision_shape(blueprint_collision_shape_scale)


func scale_blueprint_collision_shape(new_scale: float) -> void:
	if not blueprint:
		return
	if blueprint.has_method("set_collision_scale"):
		blueprint.set_collision_scale(new_scale)
	else:
		push_error("blueprint is missing 'set_collision_scale'. blueprint.name", blueprint.name)
