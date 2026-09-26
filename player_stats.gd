extends CanvasLayer

var health : int = 100
var maxHealth: int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HealthLabel.text = "Health: " + str(maxHealth)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$HealthLabel.text = "Health: " + str(health)

func take_damage(damage: int):
	health -= damage
	if health <= 0:
		health = 0

func _on_enemy_attack_player(damage: int) -> void:
	take_damage(damage)
