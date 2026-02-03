extends RigidBody2D
enum CameraMode {
	FOLLOW_PLAYER,
	PLANET_FOCUS,
	RELEASE_LAG
}

@onready var grav_well: CollisionShape2D = $gravityField/gravWell
@onready var camera_rig: Node2D = $"../CameraRig"
@export var grav_well_size := 200
@export var planetMass := 9000000
@export var dockDistThresh := 40

#signal commsEnter(obj)
#signal commsExit(obj)

#@onready var UI: CanvasLayer = $"../../UI"
#@onready var planetSizeComms: Control = $HBoxContainer/VBoxContainer/planetSizeComms
#@onready var comms_area: Marker2D = $commsArea


#var commsArea
#var size := 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("space_objects")
	print(self.name, " - radius: ",grav_well.shape.radius)
	grav_well.shape.radius = grav_well_size
	print(self.name, " - new radius: ",grav_well.shape.radius)
	#grav_well.shape.draw(get_canvas_item(), Color.DARK_BLUE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func disableGrav() -> void:
	self.grav_well.disabled = true
	
func enableGrav() -> void:
	self.grav_well.disabled = false
	
	
	
	
	
	
	
	
	
	
	
	
	
	
