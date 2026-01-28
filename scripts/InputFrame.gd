class_name InputFrame
extends RefCounted

var frame: int
var action: InputActions.Action
var pressed: bool

func _init(f: int, a: InputActions.Action, p: bool):
	frame = f
	action = a
	pressed = p

func setFrame(f: int, a: InputActions.Action, p: bool):
	frame = f
	action = a
	pressed = p
	
