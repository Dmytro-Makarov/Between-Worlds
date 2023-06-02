extends State

@export var return_state : State
@export var return_animation_node : String = "move"
@export var attack1_node : String = "attack1"
@export var attack2_node : String = "attack2"

@onready var timer : Timer = $Timer

func state_input(event : InputEvent):
	if event.is_action_pressed("attack"):
		timer.start()

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == attack1_node:
		if timer.is_stopped():
			next_state = return_state
			playback.travel(return_animation_node)
		else:
			playback.travel(attack2_node)
	
	if anim_name  == attack2_node:
		next_state = return_state
		playback.travel(return_animation_node)
