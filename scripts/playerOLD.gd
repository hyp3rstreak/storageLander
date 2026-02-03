extends RigidBody2D

@onready var incomingCallText: Label = $HBoxContainer/VBoxContainer/incomingCall
@onready var UI: CanvasLayer = $"../../UI"
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@export var thrust_force := 300.0
@export var rotation_speed := 2.0
@export var max_speed := 600.0
@export var linear_drag := 1.0

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
	#for obj in get_tree().get_nodes_in_group("space_objects"):
		#obj.commsEnter.connect(requestClearance)

func _physics_process(delta):
	# --- Rotation ---
	var turn := 0.0
	if Input.is_action_pressed("left"):
		dir = "left"
		turn -= 1.0
	if Input.is_action_pressed("right"):
		dir = "right"
		turn += 1.0
	
	angular_velocity = turn * rotation_speed

	# --- Thrust ---
	if Input.is_action_pressed("up"):
		var forward := Vector2.RIGHT.rotated(rotation)
		apply_central_force(forward * thrust_force)
		dir = "up"

	if Input.is_action_pressed("down"):
		apply_central_force(-linear_velocity * 8)
		dir = "down"
		
	if Input.is_action_pressed("interact"):
		print("interact")
		

	# --- Manual drag ---
	linear_velocity *= linear_drag
	#print(linear_velocity)
	# --- Clamp speed ---
	if linear_velocity.length() > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed		

func requestLandClearance(obj) -> void:
	print ("request sent to: ", obj.name)
	UI.show_incoming_call(obj.name)
	
func exitLandClearance(obj) -> void:
	print ("goodluck says: ", obj.name)
	UI.hide_incoming_call()	
	
