extends Camera2D

@onready var player: CharacterBody2D = $"../Player"
@onready var invisible_player: CharacterBody2D = $"../InvisiblePlayer"

@export var BASE_ZOOM = 1.5

var in_ultra_instinct_mode = false
var ultra_instinct_slow_down = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	zoom = Vector2(BASE_ZOOM, BASE_ZOOM)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_ultra_instinct_mode:
		global_position.x = invisible_player.global_position.x
	else:
		global_position.x = lerpf(global_position.x, player.global_position.x, delta * 5)


func _on_player_entered_ultra_instinct_mode(slow_down_factor: float) -> void:
	in_ultra_instinct_mode = true
	ultra_instinct_slow_down = slow_down_factor


func _on_player_left_ultra_instrinct_mode() -> void:
	in_ultra_instinct_mode = false
	ultra_instinct_slow_down = 1
	global_position.x = player.global_position.x
