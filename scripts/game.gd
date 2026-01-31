extends Node2D

@onready var controls_layer: CanvasLayer = $ControlsLayer
@onready var start_menu: CanvasLayer = $StartMenu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_menu_start_game() -> void:
	var level_scene = load("res://scenes/test_scene_eloy.tscn").instantiate()
	start_menu.visible = false
	controls_layer.visible = true

	await get_tree().create_timer(2.0).timeout
	get_tree().root.add_child(level_scene)
	controls_layer.visible = false
	queue_free()
