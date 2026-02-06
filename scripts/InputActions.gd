class_name InputActions

enum Action {
	LEFT,
	RIGHT,
	JUMP,
	ERROR,
}


static func to_str(action: Action) -> StringName:
	match action:
		Action.LEFT:
			return "left"
		Action.RIGHT:
			return "right"
		Action.JUMP:
			return "jump"
		_:
			push_error("Unknown input action: %s" % action)
			return ""


static func from_string(action: StringName) -> Action:
	match action:
		"left":
			return Action.LEFT
		"right":
			return Action.RIGHT
		"jump":
			return Action.JUMP
		_:
			push_error("Unknown input action: %s" % action)
			return Action.ERROR
