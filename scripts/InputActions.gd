class_name InputActions

enum Action{
	MOVE_LEFT,
	MOVE_RIGHT,
	JUMP,
	
	ERROR
}

static func from_string(action: StringName) -> Action:
	match action:
		"left": 	return Action.MOVE_LEFT
		"right": 	return Action.MOVE_RIGHT
		"jump": 	return Action.JUMP
		_:
			push_error("Unknown input action: %s" % action)
			return Action.ERROR
