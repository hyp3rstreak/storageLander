extends RigidBody2D
@onready var incomingCallText: Label = $HBoxContainer/VBoxContainer/incomingCall
@onready var UI: CanvasLayer = $"../../UI"
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@export var rotation_speed := 2.0
#@export var linear_drag := 0.0
@export var thrust_force := 600.0
@export var torque_force := 400.0
@export var gravity_strength := 900000.0
@export var orbit_assist := 0.5
@export var max_speed := 400.0
@onready var current_planet
@onready var body_1: StaticBody2D = $"../body1"
@onready var body_2: StaticBody2D = $"../body2"
@onready var body_3: StaticBody2D = $"../body3"


#const SPEED = 30
var dir := "up"
var canShoot := true
var inLandingZone := false
var bulletSpeed := 600
var current_space_object = null

# Called when the node enters the scene tree for the  first time.
func _ready() -> void:
	add_to_group("player")
	mass = .5


func _integrate_forces(state: PhysicsDirectBodyState2D):
	if not current_planet:
		return
	
	var to_planet = current_planet.global_position - global_position
	var dist = max(to_planet.length(), 100.0)
	var dir = to_planet.normalized()
	#var gravity_force = dir * gravity_strength / dist
	var gravity_force = dir * gravity_strength / (dist * dist)
	apply_central_force(gravity_force)
	var radial_dir = dir
	var tangent = Vector2(-radial_dir.y, radial_dir.x)
	var radial_speed = linear_velocity.dot(radial_dir)
	var tangential_speed = linear_velocity.dot(tangent)
	 


func _physics_process(delta):
	# --- Rotation ---
	if Input.is_action_pressed("left"):
		apply_torque(-torque_force)
	if Input.is_action_pressed("right"):
		apply_torque(torque_force)
	

	# --- Thrust ---
	if Input.is_action_pressed("thrust"):
		apply_central_force(transform.x * thrust_force)

	if Input.is_action_pressed("down"):
		apply_central_force(-linear_velocity * 8)
		
	if Input.is_action_pressed("interact"):
		print("interact")
		

	# --- speed limiter ---
	if linear_velocity.length() > max_speed:
		linear_velocity = linear_velocity.lerp(linear_velocity.normalized() * max_speed,0.1)


func requestLandClearance(obj) -> void:
	print ("request sent to: ", obj.name)
	UI.show_incoming_call(obj.name)
	
func exitLandClearance(obj) -> void:
	print ("goodluck says: ", obj.name)
	UI.hide_incoming_call()	
	
