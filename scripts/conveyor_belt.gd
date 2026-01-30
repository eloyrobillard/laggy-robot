extends Node2D

@onready var wheel_left: Sprite2D = $WheelLeft/WheelLeft
@onready var wheel_middle: Sprite2D = $WheelMiddle
@onready var wheel_right: Sprite2D = $WheelRight/WheelRight

var tween_left: Tween
var tween_middle: Tween
var tween_right: Tween


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tween_left = create_tween().set_loops()
	tween_left.tween_property(wheel_left, "global_rotation_degrees", -360, 2)
	tween_middle = create_tween().set_loops()
	tween_middle.tween_property(wheel_middle, "global_rotation_degrees", -360, 2)
	tween_right = create_tween().set_loops()
	tween_right.tween_property(wheel_right, "global_rotation_degrees", -360, 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
