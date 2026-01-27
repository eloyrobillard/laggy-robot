extends CanvasLayer

@onready var ultra_instinct_tint: TextureRect = $UltraInstinctTint
@onready var ultra_instinct_tint_2: TextureRect = $UltraInstinctTint2

var in_ultra_instinct_mode = false
var ultra_instinct_factor = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ultra_instinct_tint.modulate.a = 0
	ultra_instinct_tint_2.modulate.a = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_ultra_instinct_mode:
		ultra_instinct_tint.modulate.a += delta / ultra_instinct_factor
		ultra_instinct_tint_2.modulate.a += delta / ultra_instinct_factor


func _on_character_body_2d_entered_ultra_instinct_mode(slow_down_factor: float) -> void:
	in_ultra_instinct_mode = true
	ultra_instinct_factor = slow_down_factor


func _on_character_body_2d_left_ultra_instrinct_mode() -> void:
	in_ultra_instinct_mode = false

	ultra_instinct_tint.modulate.a = 0
	ultra_instinct_tint_2.modulate.a = 0
