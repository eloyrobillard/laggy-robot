extends CanvasLayer

@onready var elapsed_time: Label = $ElapsedTime

var in_game_time = 0.0
var ultra_instinct_factor
var in_ultra_instinct = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_ultra_instinct:
		in_game_time += delta * ultra_instinct_factor
	else:
		in_game_time += delta
	elapsed_time.text = "Elapsed time: {time}s".format({ "time": "%0.1f" % in_game_time })


func _on_player_entered_ultra_instinct_mode(slow_down_factor: float) -> void:
	ultra_instinct_factor = slow_down_factor
	in_ultra_instinct = true


func _on_player_left_ultra_instrinct_mode() -> void:
	in_ultra_instinct = false
