extends CharacterBody2D


@export var speed : float = 200.0

@onready var animation_tree = $AnimationTree 
@onready var animation_state = $AnimationTree.get("parameters/playback")
@onready var state_machine = $CharacterStateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : float = 0
var was_in_air : bool = false
var animation_locked : bool = false

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	

	# Get the input direction and handle the movement/deceleration.
	# Control whether to move or not to move
	direction = Input.get_axis("left", "right")
	if direction != 0 && state_machine.check_if_can_move():
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	move_and_slide()
	update_animation_parameters()
	update_scale()

func update_scale():
	if direction != 0:
		scale.x = scale.y * direction

func update_animation_parameters():
	animation_tree.set("parameters/move/blend_position", direction)
