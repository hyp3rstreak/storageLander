extends Node2D
enum CameraMode {
	FOLLOW_PLAYER,
	PLANET_FOCUS,
	RELEASE_LAG
}


@export var follow_speed := 3.0
@export var planet_bias := 0.75        # how much planet pulls camera
@export var release_delay := 0.4        # seconds to hold before returning

var mode := CameraMode.FOLLOW_PLAYER
var planet: Node2D
@onready var player: RigidBody2D = $"../playerShip"

var release_timer := 0.0

func _process(delta):
	if not player:
		return

	var target_pos := player.global_position

	match mode:
		CameraMode.FOLLOW_PLAYER:
			target_pos = player.global_position

		CameraMode.PLANET_FOCUS:
			target_pos = player.global_position.lerp(
				planet.global_position,
				planet_bias
			)

		CameraMode.RELEASE_LAG:
			release_timer -= delta
			target_pos = planet.global_position

			if release_timer <= 0:
				mode = CameraMode.FOLLOW_PLAYER

	global_position = global_position.lerp(
		target_pos,
		1.0 - exp(-follow_speed * delta)
	)
