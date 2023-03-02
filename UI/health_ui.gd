extends Control

var hearts = 4 : 
	set(value):
		hearts = clamp(value, 0, max_hearts)
		if heartUIFull != null:
			heartUIFull.size.x = hearts * 15

var max_hearts = 4 :
	set(value):
		max_hearts = max(value, 1)
		self.hearts = min(hearts, max_hearts)
		if heartUIEmpty != null:
			heartUIEmpty.size.x = max_hearts * 15

@onready var heartUIFull = $HeartUIFull
@onready var heartUIEmpty = $HeartUIEmpty

func updateHearts(value):
	hearts = value

func updateMaxHearts(value):
	max_hearts = value

func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	PlayerStats.health_changed.connect(updateHearts)
	PlayerStats.max_health_changed.connect(updateMaxHearts)
