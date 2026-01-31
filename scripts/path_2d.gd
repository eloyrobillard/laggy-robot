extends Path2D

## Greate value means slower speed
@export var inverse_speed = 5

var t = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta):
	t += delta / inverse_speed
	global_position = curve.sample_baked(t * curve.get_baked_length(), false)


func _on_player_won() -> void:
	set_process(false)


func _on_player_died() -> void:
	set_process(false)
