extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_death_menu_restart_level() -> void:
	var level = preload("res://scenes/test_scene_eloy.tscn").instantiate()
	get_tree().root.add_child(level)
	queue_free()


func _on_victory_layer_go_back_to_main_menu() -> void:
	var main_menu = load("res://scenes/game.tscn").instantiate()
	visible = false
	get_tree().root.add_child(main_menu)
	queue_free()
