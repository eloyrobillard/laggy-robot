extends CanvasLayer

@export var node: PhysicsBody2D
@onready var global_position_label: Label = $GlobalPosition
@onready var velocity_label: Label = $Velocity

var position: Vector2
var top_x: float = -INF
var top_y: float = INF
var velocity: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OS.has_feature("release"):
		visible = false
		process_mode = Node.PROCESS_MODE_DISABLED


func _physics_process(delta: float) -> void:
	position = node.global_position
	top_x = max(position.x, top_x)
	top_y = min(position.y, top_y)

	if node is CharacterBody2D:
		velocity = node.velocity
	elif node is RigidBody2D:
		velocity = node.linear_velocity

	render()


func render() -> void:
	global_position_label.text = "x, y = {x}, {y} (top: {top_x}, {top_y})".format({ "x": "%0.2f" % position.x, "y": "%0.2f" % position.y, "top_x": "%0.2f" % top_x, "top_y": "%0.2f" % top_y })
	velocity_label.text = "vx, vy = {vx}, {vy}".format({ "vx": "%0.2f" % velocity.x, "vy": "%0.2f" % velocity.y })
