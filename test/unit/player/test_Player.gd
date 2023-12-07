extends GutTest

const Player = preload("res://player/Player.tscn")
const Sawmill = preload("res://world/buildings/sawmill/sawmill.tscn")

var player: Player
var gstate := GState


func before_each() -> void:
	player = add_child_autoqfree(Player.instantiate())


# func test_interacts_on_input() -> void:
# 	var sender = InputSender.new(player)
# 	assert_false(player.lock_animation, "animation lock should be false")

# 	sender.action_down("interact")
# 	# player._input({})
# 	await wait_frames(1, "optional message")

# 	assert_true(player.lock_animation, "animation lock should be true")


func test_faces_the_building_to_interact() -> void:
	var interactable = add_child_autoqfree(Sawmill.instantiate())
	interactable.global_position = Vector2(-1, 0)
	player.global_position = Vector2(0, 0)
	player.action_radius._on_body_entered(interactable)

	player.interact()

	assert_eq(player.anim_tree["parameters/idle/blend_position"], -1)

	player.action_radius._on_body_exited(interactable)
