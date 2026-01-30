extends RigidBody2D

var impulse = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gravity_scale = 0


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	gravity_scale = 1
