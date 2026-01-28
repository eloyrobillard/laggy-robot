extends CharacterBody2D
@onready var recorder = $ActionsRecorder

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var playingRecord := false
var playbackFrame := 0
var playbackIndex := 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func PlaybackMove():
	playbackFrame += 1
	var inputs = recorder.inputList
	
	while playbackIndex < inputs.size() and inputs[playbackIndex].frame == playbackFrame:
		var e = inputs[playbackIndex]
		
		playbackIndex += 1
