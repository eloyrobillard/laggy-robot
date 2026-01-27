extends Camera2D

@export var BASE_ZOOM = 1.5

var in_ultra_instinct_mode = false
var ultra_instinct_slow_down = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_zoom()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_ultra_instinct_mode:
		zoom *= 1 + delta / ultra_instinct_slow_down
	else:
		reset_zoom()


func _on_character_body_2d_entered_ultra_instinct_mode(slow_down_factor: float) -> void:
	in_ultra_instinct_mode = true
	ultra_instinct_slow_down = slow_down_factor


func _on_character_body_2d_left_ultra_instrinct_mode() -> void:
	in_ultra_instinct_mode = false
	ultra_instinct_slow_down = 1


func reset_zoom() -> void:
	zoom = Vector2(BASE_ZOOM, BASE_ZOOM)
