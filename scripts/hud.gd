extends CanvasLayer

@onready var elapsed_time: Label = $ElapsedTime

var in_game_time = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	in_game_time += delta
	elapsed_time.text = "Elapsed time: {time}s".format({ "time": "%0.1f" % in_game_time })
