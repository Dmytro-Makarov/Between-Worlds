extends Node

class_name GameManager

signal toggle_game_paused(is_pauesd : bool)

var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		emit_signal("toggle_game_paused", game_paused)

func _input(event : InputEvent):
	if event.is_action_pressed("ui_cancel"):
		game_paused = !game_paused
	if game_paused && event.is_action_pressed("exit"):
		get_tree().quit()
