extends CanvasLayer

@onready var planetSizeComms: Control = $HBoxContainer/VBoxContainer/planetSizeComms
@onready var incomingCall: Label = $HBoxContainer/VBoxContainer/incomingCall
@onready var planetInfo1: Label = $VBoxContainer2/planetInfo1
@onready var planetInfo2: Label = $VBoxContainer2/planetInfo2
@onready var planetInfo3: Label = $VBoxContainer2/planetInfo3


func show_incoming_call(caller):
	incomingCall.visible = true
	incomingCall.text = "Incoming call from %s" % caller.name
	#planetSizeComms.custom_minimum_size = size
	
func updatePlanetInfo(planet, distance, nearPlanet) -> void:
	if nearPlanet:	
		planetInfo1.text = "Object: %s" % planet.name
		planetInfo2.text = "Mass: %s" % planet.planetMass
		planetInfo3.text = "Distance: %s" % distance
	else:
		planetInfo1.text = "..."
		planetInfo2.text = "... waiting ..."
		planetInfo3.text = "..."

func showPlanetInfo() -> void:
	planetInfo1.visible = true
	planetInfo2.visible = true
	planetInfo3.visible = true
	
func hidePlanetInfo() -> void:
	planetInfo1.visible = false
	planetInfo2.visible = false
	planetInfo3.visible = false
	
func hide_incoming_call():
	incomingCall.visible = false
