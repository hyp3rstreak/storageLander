extends CharacterBody2D
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@onready var bulletTimer: Timer = $bulletTimer
@export var bulletScene: PackedScene
@onready var bulletRelease: Marker2D = $Marker2D

const SPEED = 50
var spriteDir := "up"
var canShoot := true
var bulletSpeed := 200

# Called when the node enters the scene tree for the  first time.
func _ready() -> void:
	pass # Replace with function body.

func _bulletShoot():
	print("pew pew")
	if canShoot:
		bulletTimer.start()
		var bullet = bulletScene.instantiate()
		bullet.global_position = bulletRelease.global_position
		bullet.direction = -bulletRelease.global_transform.y
		bullet.speed = bulletSpeed
		print(bulletRelease.global_position)
		
		get_tree().current_scene.add_child(bullet)
	canShoot = false
	
func _updateAnim(dir):
	print("animator.play(",dir,")")
	animator.play(dir)
	print(velocity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	#velocity = input_dir * SPEED
	#print("Vel:::::: ",velocity)
	#get_animation(input_dir)	
	
	if Input.is_action_pressed("up"):
		spriteDir = "up"
		velocity.y -= SPEED
	elif Input.is_action_pressed("down"):
		spriteDir = "down"
		velocity.y += SPEED
	elif Input.is_action_pressed("left"):
		spriteDir = "left"
		velocity.x -= SPEED
	elif Input.is_action_pressed("right"):
		spriteDir = "right"
		velocity.x += SPEED
	else:
		spriteDir = "idle"
		
	if Input.is_action_pressed("shoot"):
		_bulletShoot()
		
	#print(spriteDir)
	_updateAnim(spriteDir)
	move_and_slide()


func _on_bullet_timer_timeout() -> void:
	canShoot = true
