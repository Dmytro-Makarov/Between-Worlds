extends Node

signal no_health
signal health_changed(value)
signal max_health_changed(value)

@export var max_health : int = 1 :
	set(value):
		max_health = value
		self.health = min(health, max_health)
		emit_signal("max_health_changed", max_health)

var health : int = max_health : 
	set(value):
		health = value
		emit_signal("health_changed", health)
		if health <= 0:
			emit_signal("no_health")

func _ready():
	self.health = max_health
