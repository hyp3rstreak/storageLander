extends Area2D

@onready var planet := get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_goal_body_entered(body: Node2D) -> void:
		if body.is_in_group("player"):
			body.requestLandClearance(planet)

func _on_goal_body_exited(body: Node2D) -> void:
		if body.is_in_group("player"):
			body.exitLandClearance(planet)
