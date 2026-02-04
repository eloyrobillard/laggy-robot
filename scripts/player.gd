extends CharacterBody2D

signal left_ultra_instrinct_mode
signal entered_ultra_instinct_mode(slow_down_factor: float)
signal died
signal won

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var recorder: Node = $ActionsRecorder

const ULTRA_INSTINCT_SLOW_DOWN = 50
const SPEED = 1000.0
const JUMP_VELOCITY = -1500.0

var in_ultra_instinct_mode = false
var ultra_instinct_factor = 1
var can_enter_ultra_instinct = true

var playingRecord := false
var playbackFrame := 0
var playbackIndex := 0
var playback_left := false
var playback_right := false


func _input(event: InputEvent) -> void:
	match event.get_class():
		"InputEventKey":
			# Handle ultra-instinct
			if Input.is_anything_pressed() and not in_ultra_instinct_mode and can_enter_ultra_instinct:
				enter_ultra_instinct()
				if not Input.is_action_just_pressed("ultra-instinct"):
					Input.parse_input_event(event)

			if Input.is_action_just_pressed("ultra-instinct") and in_ultra_instinct_mode:
				leave_ultra_instinct()


func _physics_process(delta: float) -> void:
	var direction = 0
	if playingRecord:
		direction = PlaybackMove()

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta / ultra_instinct_factor ** 2

	if direction < 0:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false

	# animations
	if velocity.y == 0:
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")

	else:
		if velocity.y > 0:
			animated_sprite_2d.play("jump-down")

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


func _on_ultra_instinct_layer_ultra_instinct_depleted() -> void:
	leave_ultra_instinct()
	can_enter_ultra_instinct = false


func enter_ultra_instinct() -> void:
	in_ultra_instinct_mode = true
	entered_ultra_instinct_mode.emit(ULTRA_INSTINCT_SLOW_DOWN)
	ultra_instinct_factor = ULTRA_INSTINCT_SLOW_DOWN

	if playingRecord:
		velocity.x = 0
	recorder.isRecording = true
	EndPlayback()


func leave_ultra_instinct() -> void:
	in_ultra_instinct_mode = false
	left_ultra_instrinct_mode.emit()
	ultra_instinct_factor = 1

	recorder.isRecording = false
	playingRecord = true


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if not in_ultra_instinct_mode:
		die()


func _on_demon_body_entered(body: Node2D) -> void:
	if body == self:
		die()


func _on_exit_body_entered(body: Node2D) -> void:
	if body == self:
		get_player_ready_for_level_end()
		won.emit()


func get_player_ready_for_level_end() -> void:
	leave_ultra_instinct()
	set_process_input(false)
	set_physics_process(false)
	animated_sprite_2d.pause()
	velocity.x = 0


func die() -> void:
	get_player_ready_for_level_end()
	died.emit()


func PlaybackMove():
	playbackFrame += 1
	var inputs = recorder.inputList

	while not in_ultra_instinct_mode and playbackIndex < inputs.size() and inputs[playbackIndex].frame == playbackFrame:
		var f = inputs[playbackIndex]

		if f.action == InputActions.Action.JUMP and is_on_floor():
			velocity.y = JUMP_VELOCITY / ultra_instinct_factor

		else:
			if f.action == InputActions.Action.LEFT:
				playback_left = f.pressed
			if f.action == InputActions.Action.RIGHT:
				playback_right = f.pressed

		playbackIndex += 1

	var dir := 0
	if playback_left:
		dir -= 1
	if playback_right:
		dir += 1

	if dir:
		velocity.x = dir * SPEED / ultra_instinct_factor
		if dir > 0:
			animated_sprite_2d.flip_h = false
		else:
			animated_sprite_2d.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED / ultra_instinct_factor)

	if playbackIndex >= inputs.size():
		EndPlayback()

	return dir


func EndPlayback():
	playbackFrame = 0
	playbackIndex = 0
	playingRecord = false
	recorder.inputList.clear()
	recorder.currentFrame = 0
	playback_left = false
	playback_right = false


func _on_press_hit_player() -> void:
	die()
	global_rotation_degrees = 90


func _on_rotary_saw_split_player_in_half() -> void:
	die()


func _on_lava_pool_player_fell_in() -> void:
	die()
