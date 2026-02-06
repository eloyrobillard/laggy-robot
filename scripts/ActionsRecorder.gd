extends Node

## Transmit new pair to show it in playback UI
signal added_frame_pair(frame_pairs: Array)

var isRecording := false
var currentFrame := 0
var inputList: Array[InputFrame] = []

## Used to pair released actions with pressed actions
## This is useful when showing the events playback in the UI
var pressedActions = { "jump": null, "left": null, "right": null }
var actionPairs: Array = []


func _physics_process(_delta):
	if isRecording and currentFrame:
		currentFrame += 1


func displayList():
	for input in inputList:
		prints(input.frame, input.action, input.pressed)


func _input(event):
	if not isRecording or event is not InputEvent or event.is_action("ultra-instinct"):
		currentFrame = 0
		return

	if currentFrame == 0:
		currentFrame = 1

	# NOTE: We save key press event to pair them with a release later on.
	# This is useful when displaying a playback guide in the UI.
	# I believe this should cause no issue, based on two observations:
	# - you cannot release a key without having first pressed it
	# - you cannot press down the same key a second time without releasing it
	# On the other hand, you CAN press a key and not release it before ultra instinct ends.
	# This implies that all press events should be "wrapped" with a release event before playback begins.
	if event.is_pressed():
		var frame
		if event.is_action_pressed("jump"):
			frame = InputFrame.new(currentFrame, InputActions.Action.JUMP, true)
			pressedActions["jump"] = frame
		elif event.is_action_pressed("left"):
			frame = InputFrame.new(currentFrame, InputActions.Action.LEFT, true)
			pressedActions["left"] = frame
		elif event.is_action_pressed("right"):
			frame = InputFrame.new(currentFrame, InputActions.Action.RIGHT, true)
			pressedActions["right"] = frame
		else:
			return

		if frame:
			inputList.append(frame)

	elif event.is_released():
		var frame
		var pair
		if event.is_action_released("jump"):
			frame = InputFrame.new(currentFrame, InputActions.Action.JUMP, false)
			pair = [pressedActions["jump"], frame]
			actionPairs.append(pair)
			pressedActions["jump"] = null
		elif event.is_action_released("left"):
			frame = InputFrame.new(currentFrame, InputActions.Action.LEFT, false)
			pair = [pressedActions["left"], frame]
			actionPairs.append(pair)
			pressedActions["left"] = null
		elif event.is_action_released("right"):
			frame = InputFrame.new(currentFrame, InputActions.Action.RIGHT, false)
			pair = [pressedActions["right"], frame]
			actionPairs.append(pair)
			pressedActions["right"] = null
		else:
			return

		if frame:
			inputList.append(frame)

		if pair[0] and pair[1]:
			added_frame_pair.emit(pair)


func _on_player_entered_ultra_instinct_mode(_slow_down_factor: float) -> void:
	inputList.clear()
	actionPairs.clear()
	currentFrame = 0


func _on_player_left_ultra_instinct_mode() -> void:
	# NOTE: wrap pressed action pairs
	var frame
	if pressedActions["jump"]:
		frame = InputFrame.new(currentFrame, InputActions.Action.JUMP, false)
		actionPairs.append([pressedActions["jump"], frame])
		pressedActions["jump"] = null
	elif pressedActions["left"]:
		frame = InputFrame.new(currentFrame, InputActions.Action.LEFT, false)
		actionPairs.append([pressedActions["left"], frame])
		pressedActions["left"] = null
	elif pressedActions["right"]:
		frame = InputFrame.new(currentFrame, InputActions.Action.RIGHT, false)
		actionPairs.append([pressedActions["right"], frame])
		pressedActions["right"] = null
	else:
		return
