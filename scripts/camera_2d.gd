extends Camera2D

@export var BASE_ZOOM = 1.5

var in_ultra_instinct_mode = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_zoom()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_ultra_instinct_mode:
		zoom *= 1 + delta
	else:
		reset_zoom()


func reset_zoom() -> void:
	zoom = Vector2(BASE_ZOOM, BASE_ZOOM)


func _on_player_entered_ultra_instinct_mode() -> void:
	in_ultra_instinct_mode = true


func _on_player_left_ultra_instrinct_mode() -> void:
	in_ultra_instinct_mode = false
