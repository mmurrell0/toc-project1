extends Node

var combatController: Node

enum States {WAIT, DECIDE, ATTACK, DEFEND, RUN_AWAY, END_COMBAT}
var state = States.WAIT

var aggressionLevel = 5
var runChance = 25
var randomNum = 6
var playerKilled: bool = false

func _ready() -> void:
	combatController = get_parent().get_parent().find_child("CombatController")

func _process(delta: float) -> void:
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

func _state_wait():
	# Do stuff maybe
	
	if get_parent().get_parent().find_child("Player Stats").health <= 0:
		_change_state(States.END_COMBAT)
		print_debug("ENDING COMBAT")
	elif combatController.state == combatController.States.ENEMY_TURN:
		_change_state(States.DECIDE)
		print_debug("DECIDING")

func _state_decide():
	# Do stuff maybe
	
	randomNum = randi_range(0, 10)
	if get_parent().find_child("EnemyHealth").health < 10:
		_change_state(States.RUN_AWAY)
		print_debug("RUNNING AWAY")
	elif randomNum >= aggressionLevel:
		_change_state(States.ATTACK)
		print_debug("ATTACKING")
	elif randomNum <= aggressionLevel:
		_change_state(States.DEFEND)
		print_debug("DEFENDING")

func _state_attack():
	# Do stuff maybe
	
	
	if playerKilled:
		_change_state(States.END_COMBAT)
		print_debug("ENDING COMBAT")
	else:
		combatController.state = combatController.States.PLAYER_TURN
		_change_state(States.WAIT)
		print_debug("PLAYERS TURN AGAIN")

func _state_defend():
	# Do stuff maybe
	
	combatController.state = combatController.States.PLAYER_TURN
	_change_state(States.WAIT)
	print_debug("PLAYERS TURN AGAIN")

func _state_run_away():
	# Do stuff maybe
	
	randomNum = randi_range(0, 100)
	if randomNum > runChance:
		_change_state(States.WAIT)
		print_debug("PLAYERS TURN AGAIN")
	elif randomNum <= runChance:
		_change_state(States.END_COMBAT)
		print_debug("ENDING COMBAT")

func _state_end_combat():
	# Do stuff maybe
	
	print_debug("COMBAT ENDED")
	owner.queue_free()

func _change_state(new_state: States):
	state = new_state
