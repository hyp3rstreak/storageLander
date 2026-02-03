extends Area2D

@onready var camera_rig: Node2D = $"../../CameraRig"

enum CameraMode {
	FOLLOW_PLAYER,
	PLANET_FOCUS,
	RELEASE_LAG
}
#@export var min_distance := 40.0
#@export var max_force := 99999999999.0

#@onready var gravitational_constant := 1.0

@onready var planet := get_parent()

func _physics_process(delta):
	pass
	#for body in get_overlapping_bodies():
		#if body is RigidBody2D:
			##print("body in gravWelld")
			#var dir := global_position.direction_to(body.global_position)
			#var distance := global_position.distance_to(body.global_position)
			#distance = max(distance, min_distance)
			#var force = gravitational_constant * planet.mass / (distance)
			#force = min(force, max_force)
			#
			## if in dock zone chill on movement
			#if distance <= min_distance:
				#force = 0
#
			#body.apply_central_force(-dir * force)

#func _on_gravity_field_body_entered(body: Node2D) -> void:
		#if body.is_in_group("player"):
			#body.requestLandClearance(planet)
			##camera_rig.planet = self
			##camera_rig.mode = CameraMode.PLANET_FOCUS
			##body.current_planet = self
			#
#func _on_gravity_field_body_exited(body: Node2D) -> void:
		#if body.is_in_group("player"):
			#body.exitLandClearance()
			##camera_rig.planet = self
			##camera_rig.mode = CameraMode.FOLLOW_PLAYER
			##body.current_planet = null
			


func _on_body_entered(body: Node2D) -> void:
		if body.is_in_group("player"):
			body.gravWellEnter(planet)
			camera_rig.planet = self
			camera_rig.mode = CameraMode.PLANET_FOCUS
			body.current_planet = self.get_parent()
			print("LLLLLLLLLLLLLLLLLLLLLLL   ",self.get_parent())


func _on_body_exited(body: Node2D) -> void:
		if body.is_in_group("player"):
			body.gravWellExit(planet)
			camera_rig.planet = self
			camera_rig.mode = CameraMode.FOLLOW_PLAYER
			body.current_planet = null
