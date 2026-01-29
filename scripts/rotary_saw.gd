extends AnimatableBody2D

signal split_player_in_half

@export var rot_speed_deg_sec: float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	rotation_degrees += rot_speed_deg_sec * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		split_player_in_half.emit()
