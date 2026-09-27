extends CanvasLayer

signal player_attacked
signal hurt_player
signal new_turn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_attack_button_pressed() -> void:
	player_attacked.emit(5)
	get_parent().find_child("CombatController").state = get_parent().find_child("CombatController").States.ENEMY_TURN
	print_debug("ENEMY TURN")
	new_turn.emit()

func _on_pass_button_pressed() -> void:
	get_parent().find_child("CombatController").state = get_parent().find_child("CombatController").States.ENEMY_TURN
	print_debug("ENEMY TURN")
	new_turn.emit()


func _on_hurt_player_button_pressed() -> void:
	hurt_player.emit(20)
	get_parent().find_child("CombatController").state = get_parent().find_child("CombatController").States.ENEMY_TURN
	print_debug("ENEMY TURN")
	new_turn.emit()
