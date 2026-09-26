extends Node

enum States {PLAYER_TURN, ENEMY_TURN}
var state = States.PLAYER_TURN

func next_turn():
	if state == States.PLAYER_TURN:
		state = States.ENEMY_TURN
	#if state == States.ENEMY_TURN:
		#state = States.PLAYER_TURN
		#print_debug("PLAYER TURN")

func _on_game_next_turn() -> void:
	next_turn()
