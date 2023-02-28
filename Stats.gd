extends Node

signal no_health

@export var max_health : int = 1
@onready var health = max_health : 
	set(value):
		health = value
		if health <= 0:
			emit_signal("no_health")
