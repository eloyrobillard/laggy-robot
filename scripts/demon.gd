extends PathFollow2D

var BASE_INV_SPEED = 17

var inverse_speed = BASE_INV_SPEED


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _process(delta):
	progress_ratio += delta / inverse_speed


func _on_player_entered_ultra_instinct_mode(slow_down_factor: float) -> void:
	inverse_speed = BASE_INV_SPEED * slow_down_factor


func _on_player_left_ultra_instinct_mode() -> void:
	inverse_speed = BASE_INV_SPEED


func _on_player_won() -> void:
	set_process(false)


func _on_player_died() -> void:
	set_process(false)
