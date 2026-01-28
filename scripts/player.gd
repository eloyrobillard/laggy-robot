extends CharacterBody2D

signal left_ultra_instrinct_mode
signal entered_ultra_instinct_mode(slow_down_factor: float)
signal died
signal won
@onready var recorder = $ActionsRecorder

const ULTRA_INSTINCT_SLOW_DOWN = 50
const SPEED = 400.0
const JUMP_VELOCITY = -800.0
const GRAV_MULT = 3

var in_ultra_instinct_mode = false
var ultra_instinct_factor = 1
var can_enter_ultra_instinct = true


func _input(event: InputEvent) -> void:
	match event.get_class():
		"InputEventKey":
			# Handle ultra-instinct
			if Input.is_action_just_pressed("ultra-instinct") and can_enter_ultra_instinct:
				if in_ultra_instinct_mode:
					leave_ultra_instinct()
				else:
					enter_ultra_instinct()

			# Handle jump.
			if Input.is_action_just_pressed("jump") and is_on_floor():
				velocity.y = JUMP_VELOCITY / ultra_instinct_factor

			# Get the input direction and handle the movement/deceleration.
			# As good practice, you should replace UI actions with custom gameplay actions.
			var direction := Input.get_axis("left", "right")
			if direction:
				velocity.x = direction * SPEED / ultra_instinct_factor
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED / ultra_instinct_factor)

var playingRecord := false
var playbackFrame := 0
var playbackIndex := 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * GRAV_MULT * delta / ultra_instinct_factor ** 2

	move_and_slide()


func _on_ultra_instinct_layer_ultra_instinct_depleted() -> void:
	leave_ultra_instinct()
	can_enter_ultra_instinct = false


func enter_ultra_instinct() -> void:
	in_ultra_instinct_mode = true
	entered_ultra_instinct_mode.emit(ULTRA_INSTINCT_SLOW_DOWN)
	ultra_instinct_factor = ULTRA_INSTINCT_SLOW_DOWN


func leave_ultra_instinct() -> void:
	in_ultra_instinct_mode = false
	left_ultra_instrinct_mode.emit()
	ultra_instinct_factor = 1


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	get_player_in_end_mode()
	died.emit()


func _on_demon_body_entered(body: Node2D) -> void:
	if body == self:
		get_player_in_end_mode()
		died.emit()


func _on_exit_body_entered(body: Node2D) -> void:
	if body == self:
		get_player_in_end_mode()
		won.emit()


func get_player_in_end_mode() -> void:
	leave_ultra_instinct()
	set_process_input(false)
	velocity.x = 0
  
	move_and_slide()

func PlaybackMove():
	playbackFrame += 1
	var inputs = recorder.inputList
	
	while playbackIndex < inputs.size() and inputs[playbackIndex].frame == playbackFrame:
		var e = inputs[playbackIndex]
		
		playbackIndex += 1
