extends RigidBody2D
enum CameraMode {
	FOLLOW_PLAYER,
	PLANET_FOCUS,
	RELEASE_LAG
}

@onready var grav_well: CollisionShape2D = $gravityField/gravWell
@onready var camera_rig: Node2D = $"../CameraRig"
@export var grav_well_size := 200
@export var gravity_mass := 9000000


signal commsEnter(obj)
signal commsExit()

#@onready var UI: CanvasLayer = $"../../UI"
#@onready var planetSizeComms: Control = $HBoxContainer/VBoxContainer/planetSizeComms
#@onready var comms_area: Marker2D = $commsArea


#var commsArea
#var size := 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("space_objects")
	print(self, " - radius: ",grav_well.shape.radius)
	grav_well.shape.radius = grav_well_size
	print(grav_well.shape.radius)
	#grav_well.shape.draw(get_canvas_item(), Color.DARK_BLUE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
