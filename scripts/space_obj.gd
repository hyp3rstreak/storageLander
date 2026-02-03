extends StaticBody2D
enum CameraMode {
	FOLLOW_PLAYER,
	PLANET_FOCUS,
	RELEASE_LAG
}
@onready var grav_well: CollisionShape2D = $gravityField/gravWell
@onready var camera_rig: Node2D = $"../CameraRig"
@export var grav_well_size := 336.0
@export var mass := 12000


signal commsEnter(spaceObject)
signal commsExit(spaceObject)

#@onready var UI: CanvasLayer = $"../../UI"
#@onready var planetSizeComms: Control = $HBoxContainer/VBoxContainer/planetSizeComms
#@onready var comms_area: Marker2D = $commsArea


#var commsArea
#var size := 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("space_objects")
	print(grav_well.shape.radius)
	grav_well.shape.radius = grav_well_size
	#grav_well.shape.draw(get_canvas_item(), Color.DARK_BLUE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_goal_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		
		print("player entered goal")
		if not commsEnter.is_connected(body.requestLandClearance):
			print("if not commsNter.is_connected")
			commsEnter.connect(body.requestLandClearance)
		#print(planetSizeComms.custom_minimum_size)
		#print(comms_area.global_position)
		#planetSizeComms.custom_minimum_size = comms_area.global_position
		emit_signal("commsEnter", self)


func _on_goal_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("player exit goal")
		if not commsExit.is_connected(body.exitLandClearance):
			print("if not commsExit.is_connected")
			commsExit.connect(body.exitLandClearance)
		emit_signal("commsExit", self)


func _on_gravity_field_body_entered(body: Node2D) -> void:
		if body.is_in_group("player"):
			camera_rig.planet = self
			camera_rig.mode = CameraMode.PLANET_FOCUS
			body.current_planet = self
			
func _on_gravity_field_body_exited(body: Node2D) -> void:
		if body.is_in_group("player"):
			camera_rig.planet = self
			camera_rig.mode = CameraMode.FOLLOW_PLAYER
			body.current_planet = null
