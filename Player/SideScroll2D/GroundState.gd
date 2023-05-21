extends State

class_name GroundState

@export var jump_velocity : float = -175.0

func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump()

func jump():
	character.velocity.y = jump_velocity
