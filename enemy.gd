extends Sprite2D

signal next_turn
signal attack_player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_actions_player_attacked(damage: int) -> void:
	$EnemyHealth.take_damage(damage)


func _on_game_next_turn() -> void:
	next_turn.emit()


func _on_enemy_state_machine_attack_player(damage: int) -> void:
	attack_player.emit(damage)
