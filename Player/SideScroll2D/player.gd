extends CharacterBody2D

#TODO: To mirror the character,
#Use flip_h for the sprite,
#and scale property for collision shape

@export var max_speed : float = 300.0
@export var acceleration : float = 200.0
@export var friction : float = 150.0
@export var double_jump_velocity : float = -150.0

@onready var animaton_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree 
@onready var animation_state = $AnimationTree.get("parameters/playback")
@onready var state_machine = $CharacterStateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var direction : float = 0
var was_in_air : bool = false
var animation_locked : bool = false

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 10:
			was_in_air = true
	else:
		has_double_jumped = false
		if was_in_air == true:
			land()
		was_in_air = false
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			#Normal jump from floor
			#jump()
			pass
		elif not has_double_jumped:
			#Double jump in air
			double_jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#TODO: stop player when landing
	direction = Input.get_axis("left", "right")
	if direction != 0 && state_machine.check_if_can_move():
		velocity.x = direction * acceleration
	else:
		velocity.x = move_toward(velocity.x, 0, friction)
		
	move_and_slide()
	update_scale()
	update_animation()

func update_scale():
	if direction != 0:
		scale.x = scale.y * direction

func update_animation():
	animation_tree.set("parameters/move/blend_position", direction)
	
	if not animation_locked:
		if not is_on_floor():
			animation_state.travel("jump_loop")
			
		else:
			animation_state.travel("move")
		


func double_jump():
	
	velocity.y = double_jump_velocity
	animation_state.travel("jump_start")
	animation_locked = true
	has_double_jumped = true

func land():
	#animaton_player.speed_scale = 3
	animation_state.travel("jump_end")
	animation_locked = true
	velocity = Vector2.ZERO;


func _on_animation_tree_animation_finished(anim_name):
	if ["jump_start", "jump_end"].has(anim_name):
		animation_locked = false


func _on_animation_tree_animation_started(anim_name):
	if anim_name == "jump_end":
		velocity.x = 0
		
