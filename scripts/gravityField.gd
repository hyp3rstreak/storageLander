extends Area2D

@export var gravitational_constant := 1.0
@export var min_distance := 40.0
@export var max_force := 44000.0
@onready var UI: CanvasLayer = $"../../../UI"
@onready var cameraRig: Node2D = $"../../CameraRig"



@onready var planet := get_parent()

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if body is RigidBody2D:
			var dir := global_position.direction_to(body.global_position)
			#print(dir)
			var distance := global_position.distance_to(body.global_position)
			#print(distance)
			distance = max(distance, min_distance)
			var force = gravitational_constant * planet.mass / (distance)
			force = min(force, max_force)
			if distance == min_distance:
				#print("safe comms zone")
				#incomingCall.visible = true
				#UI.show_incoming_call()
				force = 0
			#else:
				#incomingCall.visible = false
				#UI.hide_incoming_call()
				
			
			#print(force)
			#print(dir*force)

			body.apply_central_force(-dir * force)


#func _on_body_entered(body: Node2D) -> void:
	#if body.is_in_group("player"):
		#cameraRig.planet = self
		#cameraRig.mode = CameraMode.PLANET_FOCUS
