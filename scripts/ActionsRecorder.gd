extends Node

var isRecording := true
var currentFrame := 0
var inputList : Array[InputFrame] = []

func _physics_process(_delta):
	if isRecording:
		currentFrame += 1
		
func _input(event):
	if not isRecording:
		return
	if event.is_action_pressed("jump"):
		print("Jumped!")
