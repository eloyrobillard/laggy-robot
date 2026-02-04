class_name InputFrame
extends RefCounted

var frame: int
var action: InputActions.Action
var pressed: bool


func _init(_frame: int, _action: InputActions.Action, _pressed: bool):
	frame = _frame
	action = _action
	pressed = _pressed


func setFrame(f: int, a: InputActions.Action, p: bool):
	frame = f
	action = a
	pressed = p
