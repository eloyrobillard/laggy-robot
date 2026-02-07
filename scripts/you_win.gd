extends CanvasLayer

signal go_back_to_main_menu

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_won() -> void:
	visible = true
	audio_stream_player.play()

	await get_tree().create_timer(3.0).timeout
	go_back_to_main_menu.emit()
