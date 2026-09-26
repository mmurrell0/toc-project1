extends Node

var combatController: Node
signal attack_player

# Enum of states corresponding to the automata
enum States {WAIT, DECIDE, ATTACK, DEFEND, RUN_AWAY, END_COMBAT}
# Start state
var state = States.WAIT

# How aggress the enemy is
var aggressionLevel = 5
# How likely the enemy is to run away
var runChance = 25
# Random number input variable
var randomNum = 6
var playerKilled: bool = false

func _ready() -> void:
	combatController = get_parent().get_parent().find_child("CombatController")

func _process(delta: float) -> void:
	pass


func _state_wait():
	# Do stuff maybe
	
	# If the enemy dies during the player's turn transition to end combat state
	if get_parent().find_child("EnemyHealth").health <= 0:
		_change_state(States.END_COMBAT)
		print_debug("ENEMY DIED")
		print_debug("ENDING COMBAT")
		_process_states()
	# Else if recieves input that its the enemies turn transition to decide state
	elif combatController.state == combatController.States.ENEMY_TURN:
		_change_state(States.DECIDE)
		print_debug("DECIDING")
		_process_states()
	

func _state_decide():
	# Do stuff maybe
	
	# Generate a random number for input
	randomNum = randi_range(0, 10)
	# If the enemy health is less than 10 transition to run away state
	if get_parent().find_child("EnemyHealth").health < 10:
		_change_state(States.RUN_AWAY)
		print_debug("RUNNING AWAY")
		_process_states()
	# Else if the random number input is greater or equal to 
	# the agression level transition to the attack state
	elif randomNum >= aggressionLevel:
		_change_state(States.ATTACK)
		print_debug("ATTACKING")
		_process_states()
	# Else if the random number input is less than 
	# the agression level transition to the defending state
	elif randomNum < aggressionLevel:
		_change_state(States.DEFEND)
		print_debug("DEFENDING")
		_process_states()

func _state_attack():
	# Do stuff maybe
	attack_player.emit(20)
	
	# If the player is killed during the attack transition to the end combat state
	if playerKilled:
		_change_state(States.END_COMBAT)
		print_debug("ENDING COMBAT")
		_process_states()
	# Else transition to the wait state and signal that it is the player's turn
	else:
		combatController.state = combatController.States.PLAYER_TURN
		_change_state(States.WAIT)
		print_debug("PLAYERS TURN AGAIN")
		_process_states()

func _state_defend():
	# Do stuff maybe
	
	# Signal that it is the player's turn, and transition to the wait state
	combatController.state = combatController.States.PLAYER_TURN
	_change_state(States.WAIT)
	print_debug("PLAYERS TURN AGAIN")
	_process_states()

func _state_run_away():
	# Do stuff maybe
	
	# Generate a random number between 0 and 100
	randomNum = randi_range(0, 100)
	# If the random number input is greater than runChance then transition to the wait state
	# Enemy failed to run
	if randomNum > runChance:
		_change_state(States.WAIT)
		print_debug("PLAYERS TURN AGAIN")
		_process_states()
	# Else if the random number input os less than or equal to the runChance then transtion
	# to the end combat state, Enemy successfully ran away
	elif randomNum <= runChance:
		_change_state(States.END_COMBAT)
		print_debug("ENDING COMBAT")
		_process_states()

func _state_end_combat():
	# Do stuff maybe
	
	# End the combat by removing the enemy
	print_debug("COMBAT ENDED")
	owner.queue_free()

# Function to set the new state of the enemy
func _change_state(new_state: States):
	state = new_state

func _process_states():
	match state:
		States.WAIT:
			_state_wait()
		States.DECIDE:
			_state_decide()
		States.ATTACK:
			_state_attack()
		States.DEFEND:
			_state_defend()
		States.RUN_AWAY:
			_state_run_away()
		States.END_COMBAT:
			_state_end_combat()

func _on_enemy_next_turn() -> void:
	_process_states()
