extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -800.0
const GRAV_MULT = 3


func _unhandled_input(event: InputEvent) -> void:
	match event.get_class():
		"InputEventKey":
			# Handle jump.
			if Input.is_action_just_pressed("jump") and is_on_floor():
				velocity.y = JUMP_VELOCITY

			# Get the input direction and handle the movement/deceleration.
			# As good practice, you should replace UI actions with custom gameplay actions.
			var direction := Input.get_axis("left", "right")
			if direction:
				velocity.x = direction * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * GRAV_MULT * delta

	move_and_slide()
