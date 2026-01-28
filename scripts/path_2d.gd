extends Path2D

const BASE_INV_SPEED = 5

var inverse_speed = BASE_INV_SPEED
var t = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta):
	t += delta / inverse_speed
	global_position = curve.sample_baked(t * curve.get_baked_length(), false)


func _on_player_entered_ultra_instinct_mode(slow_down_factor: float) -> void:
	inverse_speed = BASE_INV_SPEED * slow_down_factor


func _on_player_left_ultra_instrinct_mode() -> void:
	inverse_speed = BASE_INV_SPEED


func _on_player_won() -> void:
	set_process(false)
