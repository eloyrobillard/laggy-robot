class_name InputActions

enum Action{
	LEFT,
	RIGHT,
	JUMP,
	
	ERROR
}

static func from_string(action: StringName) -> Action:
	match action:
		"left": 	return Action.LEFT
		"right": 	return Action.RIGHT
		"jump": 	return Action.JUMP
		_:
			push_error("Unknown input action: %s" % action)
			return Action.ERROR
