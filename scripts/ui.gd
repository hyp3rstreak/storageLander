extends CanvasLayer

@onready var planetSizeComms: Control = $HBoxContainer/VBoxContainer/planetSizeComms
@onready var incomingCall: Label = $HBoxContainer/VBoxContainer/incomingCall

func show_incoming_call(caller):
	incomingCall.visible = true
	incomingCall.text = "Incoming call from %s" % caller
	#planetSizeComms.custom_minimum_size = size
	

func hide_incoming_call():
	incomingCall.visible = false
