extends CanvasLayer

signal restart_level

@onready var try_again: Button = $TryAgain
@onready var quit: Button = $Quit
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_died() -> void:
	visible = true
	audio_stream_player.play()


func _on_try_again_button_down() -> void:
	restart_level.emit()


func _on_quit_button_down() -> void:
	get_tree().quit()
