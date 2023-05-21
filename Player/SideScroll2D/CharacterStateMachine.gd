extends Node

class_name CharacterStateMachine

@export var character : CharacterBody2D
@export var current_state : State

var states : Array[State]

func _ready():
	for child in get_children():
		if child is State:
			states.append(child)
			child.character = character 
			
			#Set the states up with what they need to function
		else:
			push_warning("Child " + child.name + " is not a State for " + name)

func check_if_can_move():
	return current_state.can_move
