extends AnimatableBody2D

## y_top_limit sets how far the platform will travel upward
## The farther in the negative direction, the farther up
@export var y_top_limit: float = 0
## y_bottom_limit sets how far the platform will travel downward
## The farther in the positive direction, the farther down
@export var y_bottom_limit: float = 0
## x_right_limit sets how far the platform will travel to the right
@export var x_right_limit: float = 0
## x_left_limit sets how far the platform will travel to the left
@export var x_left_limit: float = 0

@export var speed_x: float = 1
@export var speed_y: float = 1

## How long to pause when either limit is reached, before switching direction
@export var pause_at_end_sec: float

enum DirectionX {
	LEFT = -1,
	NONE = 0,
	RIGHT = 1,
}

enum DirectionY {
	UP = -1,
	NONE = 0,
	DOWN = 1,
}

@export var start_direction_x: DirectionX = DirectionX.NONE
@export var start_direction_y: DirectionY = DirectionY.NONE

var direction_x: DirectionX = DirectionX.NONE
var direction_y: DirectionY = DirectionY.NONE

var local_x_right_limit: float
var local_x_left_limit: float
var local_y_top_limit: float
var local_y_bottom_limit: float


func _ready() -> void:
	direction_x = start_direction_x
	direction_y = start_direction_y
	local_x_right_limit = global_position.x + x_right_limit
	local_x_left_limit = global_position.x + x_left_limit
	local_y_top_limit = global_position.y + y_top_limit
	local_y_bottom_limit = global_position.y + y_bottom_limit


func _physics_process(delta: float) -> void:
	var delta_x = process_x_movement(delta)
	var delta_y = process_y_movement(delta)
	global_position += Vector2(delta_x, delta_y)


var x_timer = 0


func process_x_movement(delta: float) -> float:
	if direction_x == DirectionX.NONE:
		return 0

	if global_position.x < local_x_left_limit:
		x_timer += delta
		if x_timer > pause_at_end_sec:
			global_position.x = local_x_left_limit
			direction_x = DirectionX.RIGHT
			x_timer = 0
		else:
			return 0

	elif global_position.x > local_x_right_limit:
		x_timer += delta
		if x_timer > pause_at_end_sec:
			global_position.x = local_x_right_limit
			direction_x = DirectionX.LEFT
			x_timer = 0
		else:
			return 0

	return direction_x * speed_x * delta


var y_timer = 0


func process_y_movement(delta: float) -> float:
	if direction_y == DirectionY.NONE:
		return 0

	if global_position.y < local_y_top_limit:
		y_timer += delta
		if y_timer > pause_at_end_sec:
			global_position.y = local_y_top_limit
			direction_y = DirectionY.DOWN
			y_timer = 0
		else:
			return 0

	elif global_position.y > local_y_bottom_limit:
		y_timer += delta
		if y_timer > pause_at_end_sec:
			global_position.y = local_y_bottom_limit
			direction_y = DirectionY.UP
			y_timer = 0
		else:
			return 0

	return direction_y * speed_y * delta


func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	if y_top_limit > y_bottom_limit:
		warnings.push_back("Bottom limit must be greater than top limit (Y grows in the downward direction; they can be equal to signify lack of movement on the Y axis)")

	if x_left_limit > x_right_limit:
		warnings.push_back("Left limit must be smaller than right limit (X grows in the right direction; they can be equal to signify lack of movement on the X axis)")

	return warnings
