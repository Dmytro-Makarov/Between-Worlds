extends State

class_name HitState

@export var damagable : Damagable 
@export var dead_state : State
@export var return_state : State
@export var dead_animation_node : String = "dead"
@export var knockback_speed : float = 75.0

@onready var timer : Timer = $Timer

func _ready():
	damagable.connect("on_hit", on_damagable_hit)

func on_enter():
	timer.start()

func on_damagable_hit(_node : Node, _damage_amount : int, knockback_direction : Vector2):
	if(damagable.health > 0):
		character.velocity = knockback_speed * knockback_direction
		emit_signal("interrupt_state", self)
	else:
		emit_signal("interrupt_state", dead_state)
		playback.travel(dead_animation_node)

func on_exit():
	character.velocity = Vector2.ZERO


func _on_timer_timeout():
	next_state = return_state
