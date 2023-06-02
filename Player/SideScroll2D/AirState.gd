extends State

class_name AirState

@export var landing_state : State
@export var double_jump_velocity : float = -150
@export var double_jump_animation : String = "jump_mid"
@export var landing_animation : String = "jump_end"

var has_double_jumped = false

func state_process(_delta):
	if(character.is_on_floor()):
		next_state = landing_state
		
func state_input(event : InputEvent):
	if(event.is_action_pressed("jump") && !has_double_jumped):
		double_jump()

func on_exit():
	if(next_state == landing_state):
		playback.travel(landing_animation)
		has_double_jumped = false

#TODO: When double jump, doesn't go to mid jump animation
func double_jump():
	character.velocity.y = double_jump_velocity
	playback.travel(double_jump_animation)
	has_double_jumped = true

func _on_floor_check_area_entered(_area):
	state_process(get_process_delta_time())
