extends CharacterBody2D

@onready var player: CharacterBody2D = $"../Player"

const SPEED = 1000

var in_ultra_instinct_mode = false


func _ready() -> void:
	global_position.x = player.global_position.x


func _physics_process(delta: float) -> void:
	if in_ultra_instinct_mode:
		var direction = Input.get_axis("left", "right")
		velocity.x = direction * SPEED

		move_and_slide()
		if check_box():
			velocity.x = direction * SPEED


func check_box():
	var collided_with_box = false
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("box"):
			collider.apply_impulse(-collision.get_normal() * SPEED)
			collided_with_box = true

	return collided_with_box


func _on_player_entered_ultra_instinct_mode(slow_down_factor: float) -> void:
	in_ultra_instinct_mode = true
	global_position.x = player.global_position.x


func _on_player_left_ultra_instinct_mode() -> void:
	in_ultra_instinct_mode = false
