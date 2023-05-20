extends CharacterBody2D

#TODO: To mirror the character,
#Use flip_h for the sprite,
#and scale property for collision shape

@export var speed : float = 200.0
@export var jump_velocity : float = -175.0
@export var double_jump_velocity : float = -150.0

@onready var animation_tree = $AnimationTree 
@onready var animation_state = $AnimationTree.get("parameters/playback")

@onready var idle_sprite = $SpriteNode/IdleSprite
@onready var run_sprite = $SpriteNode/RunSprite
@onready var jump_sprite = $SpriteNode/JumpSprite


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var direction: Vector2 = Vector2.ZERO


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		has_double_jumped = false
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			#Normal jump from floor
			velocity.y = jump_velocity
		elif not has_double_jumped:
			#Double jump in air
			#+= adds momentum in immediate jump
			velocity.y = double_jump_velocity
			has_double_jumped = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity.x = direction.x * speed
		scale.x = scale.y * direction.x
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	_update_animation()

func _update_animation():
	idle_sprite.visible = false
	run_sprite.visible = false
	jump_sprite.visible = false
	
	if direction.x != 0:
		animation_state.travel("Run")
		run_sprite.visible = true
	else:
		animation_state.travel("Idle");
		idle_sprite.visible = true
