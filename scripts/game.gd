extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_menu_start_game() -> void:
	var level_1 = preload("res://scenes/test_scene_eloy.tscn").instantiate()
	get_tree().root.add_child(level_1)
	queue_free()
