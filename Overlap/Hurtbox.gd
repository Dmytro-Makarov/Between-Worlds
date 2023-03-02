extends Area2D

signal invincibility_started
signal invincibility_ended

const HitEffect = preload("res://Effects/HitEffect.tscn")

@onready var timer = $Timer
@onready var collisionShape = $CollisionShape2D

var invincible = false :
	set(value):
		invincible = value
		if invincible == true:
			emit_signal("invincibility_started")
		else:
			emit_signal("invincibility_ended")
			
func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)

func create_hit_effect():
	var effect = HitEffect.instantiate()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position


func _on_timer_timeout():
	self.invincible = false


func _on_invincibility_started():
	collisionShape.set_deferred("disabled", true)


func _on_invincibility_ended():
	collisionShape.disabled = false
