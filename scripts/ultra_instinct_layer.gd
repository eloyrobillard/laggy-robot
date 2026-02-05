extends CanvasLayer

signal ultra_instinct_depleted

@onready var ultra_instinct_tint: Panel = $UltraInstinctTint
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var player_position: ColorRect = $PlayerPosition
@onready var playback_v_box: VBoxContainer = $PlaybackPanel/ScrollContainer/PlaybackVBox

@export var MAX_ULTRA_INSTINCT_SEC := 20.0

var in_ultra_instinct_mode = false
var ultra_instinct_factor = 1
var current_ultra_instinct_sec
var current_ultra_instinct_percent
var action_lines: Array


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ultra_instinct_tint.visible = false
	current_ultra_instinct_sec = MAX_ULTRA_INSTINCT_SEC


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_ultra_instinct_mode:
		current_ultra_instinct_sec -= delta
		current_ultra_instinct_percent = current_ultra_instinct_sec / MAX_ULTRA_INSTINCT_SEC * 100.0
		progress_bar.set_value_no_signal(current_ultra_instinct_percent)

		# NOTE: checking .value because I set step to 1, meaning it gets rounded to the nearest integer
		# current_ultra_instinct_percent never reaches exactly 0%
		if progress_bar.value == 0:
			ultra_instinct_depleted.emit()


func _on_player_entered_ultra_instinct_mode(slow_down_factor: float) -> void:
	in_ultra_instinct_mode = true
	ultra_instinct_tint.visible = true
	player_position.visible = true


func _on_player_left_ultra_instrinct_mode() -> void:
	in_ultra_instinct_mode = false
	ultra_instinct_tint.visible = false
	player_position.visible = false


func _on_player_recorded_action(action: Array) -> void:
	var begin = action[0].frame
	var end = action[1].frame

	# find line to put action in
	var i = 0
	while true:
		# line doesn't exist yet, so it can be used
		if i >= action_lines.size():
			break

		var line = action_lines[i]
		var overlap = line.any(func(cur): return intervals_overlap(cur[0].frame, cur[1].frame, begin, end))

		# if no overlap, this line can be used
		if not overlap:
			break

		i += 1

	# compute time since previous action to check how much margin should be shown before label
	# if no previous action on line, get time since beginning of first action
	var prev_end = begin
	if i >= action_lines.size():
		action_lines.push_back([])
		playback_v_box.add_child(HBoxContainer.new())

		# no previous action on the current line
		prev_end = 0
	# if putting new action in a previous line, get last action on that line
	else:
		prev_end = action_lines[i].back()[1].frame
	action_lines[i].push_back(action)

	# create new label inside a margin container at line i
	# NOTE: I'll use one px per frame for now
	var margin_px = begin - prev_end
	var margin_container = MarginContainer.new()
	margin_container.add_theme_constant_override("margin_left", margin_px)
	playback_v_box.get_child(i).add_child(margin_container)

	# TODO: 文字をクリッピングするとScrollContainerやHBoxContainerを使うとサイズは０になってしまう？
	# 手動で位置を指定すれば？
	var label = Label.new()
	# label.clip_text = true
	label.text = "Foo"
	label.add_theme_font_size_override("normal_font_size", 32)
	label.size.x = end - begin
	margin_container.add_child(label)


func intervals_overlap(b1: int, e1: int, b2: int, e2: int) -> bool:
	return not (e2 <= b1 or e1 <= b2)
