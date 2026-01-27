extends Camera2D

var in_ultra_instinct_mode = false
var ultra_instinct_slow_down = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_ultra_instinct_mode:
		zoom *= 1 + delta / ultra_instinct_slow_down


func _on_character_body_2d_entered_ultra_instinct_mode(slow_down_factor: float) -> void:
	in_ultra_instinct_mode = true
	ultra_instinct_slow_down = slow_down_factor
