extends CanvasLayer

signal ultra_instinct_depleted

@onready var ultra_instinct_tint: TextureRect = $UltraInstinctTint
@onready var ultra_instinct_tint_2: TextureRect = $UltraInstinctTint2
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var player_position: ColorRect = $PlayerPosition

@export var MAX_ULTRA_INSTINCT_SEC := 20.0

var in_ultra_instinct_mode = false
var ultra_instinct_factor = 1
var current_ultra_instinct_sec
var current_ultra_instinct_percent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ultra_instinct_tint.modulate.a = 0
	ultra_instinct_tint_2.modulate.a = 0
	ultra_instinct_tint.visible = true
	ultra_instinct_tint_2.visible = true
	current_ultra_instinct_sec = MAX_ULTRA_INSTINCT_SEC


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_ultra_instinct_mode:
		ultra_instinct_tint.modulate.a += delta / ultra_instinct_factor
		ultra_instinct_tint_2.modulate.a += delta / ultra_instinct_factor
		current_ultra_instinct_sec -= delta
		current_ultra_instinct_percent = current_ultra_instinct_sec / MAX_ULTRA_INSTINCT_SEC * 100.0
		progress_bar.set_value_no_signal(current_ultra_instinct_percent)

		# NOTE: checking .value because I set step to 1, meaning it gets rounded to the nearest integer
		# current_ultra_instinct_percent never reaches exactly 0%
		if progress_bar.value == 0:
			ultra_instinct_depleted.emit()


func _on_player_entered_ultra_instinct_mode(slow_down_factor: float) -> void:
	in_ultra_instinct_mode = true
	ultra_instinct_factor = slow_down_factor
	player_position.visible = true


func _on_player_left_ultra_instrinct_mode() -> void:
	in_ultra_instinct_mode = false
	player_position.visible = false

	ultra_instinct_tint.modulate.a = 0
	ultra_instinct_tint_2.modulate.a = 0
