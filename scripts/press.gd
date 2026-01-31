extends Node2D

signal hit_player

@onready var press_body: AnimatableBody2D = $PressBody

@export var time_to_bottom: float = 1
@export var time_to_top: float = 1
@export var pause_bottom: float = 1
@export var pause_top: float = 1
@export var transition_down: Tween.TransitionType
@export var transition_up: Tween.TransitionType
@export var ease_down: Tween.EaseType
@export var ease_up: Tween.EaseType

var y_tween: Tween
var size_shaft_px = 560


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	y_tween = create_tween().set_loops()
	y_tween.tween_property(press_body, "position:y", press_body.position.y + size_shaft_px, time_to_bottom).set_trans(transition_down).set_ease(ease_down)
	y_tween.tween_interval(pause_bottom)
	y_tween.tween_property(press_body, "position:y", press_body.position.y, time_to_top).set_trans(transition_up).set_ease(ease_up)
	y_tween.tween_interval(pause_top)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_press_body_body_entered(body: Node) -> void:
	if body is CharacterBody2D:
		hit_player.emit()
