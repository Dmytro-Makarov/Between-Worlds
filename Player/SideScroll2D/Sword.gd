extends Area2D

@export var damage : int = 10

func _ready():
	monitoring = false

func _on_body_entered(body):
	for child in body.get_children():
		if child is Damagable:
			var direction_to_damagable = (body.global_position - get_parent().global_position)
			var direction_sign = sign(direction_to_damagable.x)
			
			if direction_sign > 0:
				child.hit(damage, Vector2.RIGHT)
			elif direction_sign < 0:
				child.hit(damage, Vector2.LEFT)
			else:
				child.hit(damage, Vector2.ZERO)

