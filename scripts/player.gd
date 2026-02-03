extends RigidBody2D

# =========================
# CONFIG
# =========================

@export var thrust_force := 150.0
@export var torque_force := 400.0

@onready var UI: CanvasLayer = $"../../UI"

#@export var gravity_strength = space_obj.mass   # Planet mass, basically
#@export var orbit_assist := 0.3   # How much we damp radial motion
#@export var max_speed := 400.0

@onready var current_planet: Node2D = null
@onready var shipHover := false

# =========================
# SETUP
# =========================

func _ready() -> void:
	add_to_group("player")
	mass = .5

# =========================
# PHYSICS — GRAVITY + ORBIT
# =========================
# This runs *inside* the physics solver.
# Perfect for gravity and orbital math.

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if current_planet == null:
		#print(self.global_position.x)
		#print("moving in space")
		return

	#print("moving in gravity well")
	# Vector from ship → planet
	var to_planet := current_planet.global_position - global_position
	#var distance = max(to_planet.length(), 40.0)
	var distance = to_planet.length()
	# Direction toward planet
	var radial_dir := to_planet.normalized()

	# --- Gravity ---
	# Inverse-square gravity: stronger up close, smoother overall
	var gravity_strength = current_planet.gravity_mass
	var gravity_force = radial_dir * gravity_strength / (distance * distance)
	
	var tangent_dir := Vector2(-radial_dir.y, radial_dir.x)
	var radial_speed := linear_velocity.dot(radial_dir)
	var tangential_speed := linear_velocity.dot(tangent_dir)
	print("radial:", radial_speed, " tangential:", tangential_speed)
	
	if distance < 60:
		gravity_force = Vector2.ZERO
	#else:
		#shipHover = false
	#if shipHover == true:
		#gravity_force = Vector2.ZERO
	apply_central_force(gravity_force)
		
	print(gravity_force, " gravForce")
	print(distance, " distance")

	# --- Velocity decomposition ---
	# Split current velocity into:
	# 1) radial (toward/away from planet)
	# 2) tangential (sideways, orbit motion)




	# --- Orbit assist/stats ---
	# We gently damp ONLY radial motion.
	# This helps prevent spiraling in or escaping,
	# without killing sideways (orbit) speed.

	#var ideal_orbit_speed := sqrt(gravity_strength / distance)
	#print("ideal orbit speed - ", ideal_orbit_speed)

# =========================
# INPUT — THRUST + ROTATION
# =========================
# Player intent lives here.
# We apply forces only — no direct velocity setting.

func _physics_process(delta: float) -> void:

	# --- Rotation ---
	if Input.is_action_pressed("left"):
		apply_torque(-torque_force)

	if Input.is_action_pressed("right"):
		apply_torque(torque_force)

	# --- Forward thrust ---
	if Input.is_action_pressed("thrust"):
		apply_central_force(transform.x * thrust_force)

	# --- Brake (retro-thrust) ---
	if Input.is_action_pressed("down"):
		apply_central_force(-linear_velocity * 8.0)
	
func requestLandClearance(obj) -> void:
	print("hail ", obj.name)
	UI.show_incoming_call(obj.name)
func exitLandClearance() -> void:
	UI.hide_incoming_call()
	print("exit")
	
func gravWellEnter(obj) -> void:
	current_planet = obj
	print(current_planet)
	print("entering gravWell of ",obj.name)
	print(obj.name, " gravity_mass = ", obj.gravity_mass)
	print(obj.name, " gravWell size= ",obj.grav_well_size)
func gravWellExit() -> void:
	print("exit")
