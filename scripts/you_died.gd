extends CanvasLayer

signal restart_level

@onready var you_died_audio: AudioStreamPlayer = $YouDiedAudio


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_died() -> void:
	visible = true
	you_died_audio.play()

	await get_tree().create_timer(3.0).timeout
	restart_level.emit()
