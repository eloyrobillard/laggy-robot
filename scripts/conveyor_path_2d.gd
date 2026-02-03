extends Path2D

@onready var path_follow_2d: PathFollow2D = $PathFollow2D

@export var numFollowers = 50


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(numFollowers):
		var inv = 1.0 / numFollowers
		var clutch = path_follow_2d.duplicate()
		add_child(clutch)
		clutch.progress_ratio = i * inv
		
	path_follow_2d.free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
