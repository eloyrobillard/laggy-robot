extends Node

var isRecording := false
var currentFrame := 0
var inputList: Array[InputFrame] = []


func _physics_process(_delta):
	if isRecording:
		currentFrame += 1


func displayList():
	for input in inputList:
		prints(input.frame, input.action, input.pressed)


func _unhandled_input(event):
	if not isRecording or event is not InputEvent:
		return

	if event.is_pressed():
		var action = InputActions.Action.ERROR
		if event.is_action_pressed("jump"):
			action = InputActions.Action.JUMP
		elif event.is_action_pressed("left"):
			action = InputActions.Action.LEFT
		elif event.is_action_pressed("right"):
			action = InputActions.Action.RIGHT
		else:
			return

		var frame = InputFrame.new(currentFrame, action, true)
		inputList.append(frame)

	elif event.is_released():
		var action = InputActions.Action.ERROR
		if event.is_action_released("jump"):
			action = InputActions.Action.JUMP
		elif event.is_action_released("left"):
			action = InputActions.Action.LEFT
		elif event.is_action_released("right"):
			action = InputActions.Action.RIGHT
		else:
			return

		var frame = InputFrame.new(currentFrame, action, false)
		inputList.append(frame)
