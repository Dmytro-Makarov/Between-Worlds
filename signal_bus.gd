extends Node

enum TRANSPORTED_FROM {
	LEFT,
	RIGHT,
	UP,
	DOWN,
	TELEPORTED
}

signal on_health_changed(node : Node, amount_changed : int)

signal on_player_transported(node : Node, transported_from : TRANSPORTED_FROM)
