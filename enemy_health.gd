extends CanvasLayer

var health : int = 25
var maxHealth: int = 25

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HealthLabel.text = "Enemy Health: " + str(maxHealth)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$HealthLabel.text = "Enemy Health: " + str(health)

func take_damage(damage: int):
	health -= damage
	if health <= 0:
		health = 0

func _on_player_actions_player_attacked(damage: int) -> void:
	take_damage(damage)
