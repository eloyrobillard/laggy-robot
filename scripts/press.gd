extends Node2D

signal hit_player

@onready var press_body: AnimatableBody2D = $PressBody
@onready var animation_player: AnimationPlayer = $PressBody/AnimationPlayer

var animation_position_when_entered_ultra_instinct: float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_press_body_body_entered(body: Node) -> void:
	if body is CharacterBody2D:
		hit_player.emit()
		animation_player.pause()


func _on_player_entered_ultra_instinct_mode(_slow_down_factor: float) -> void:
	animation_position_when_entered_ultra_instinct = animation_player.current_animation_position


func _on_player_left_ultra_instinct_mode() -> void:
	animation_player.seek(animation_position_when_entered_ultra_instinct)
