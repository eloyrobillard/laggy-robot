class_name VirtualInput

var actions:= {}

func press(action: InputActions.Action):
	actions[action] = true
	
func release(action: InputActions.Action):
	actions[action] = false
	
func is_pressed(action: InputActions) -> bool:
	return actions.get(action, false)
