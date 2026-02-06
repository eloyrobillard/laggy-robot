extends CanvasLayer

signal ultra_instinct_depleted

@onready var ultra_instinct_tint: Panel = $UltraInstinctTint
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var player_position: ColorRect = $PlayerPosition
@onready var playback_panel: Panel = $PlaybackPanel

@export var MAX_ULTRA_INSTINCT_SEC := 20.0

const PLAYBACK_UI_SCALE_X = 10
const PLAYBACK_UI_PADDING_LEFT = 25

var in_ultra_instinct_mode = false
var ultra_instinct_factor = 1
var current_ultra_instinct_sec
var current_ultra_instinct_percent
var action_lines: Array
var label_lines: Array


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


func _physics_process(_delta: float) -> void:
	if not in_ultra_instinct_mode:
		# NOTE: ActionsRecorder increments the current frame in _physics_process,
		# so updating the left scroll here is the only way to match the actual playback timing.
		scroll_playback_ui_to_left(PLAYBACK_UI_SCALE_X)


func _on_player_entered_ultra_instinct_mode(slow_down_factor: float) -> void:
	in_ultra_instinct_mode = true
	ultra_instinct_tint.visible = true
	player_position.visible = true

	action_lines = []

	for line in label_lines:
		for label in line:
			playback_panel.remove_child(label)
			label.free()
	label_lines = []


func _on_player_left_ultra_instinct_mode() -> void:
	in_ultra_instinct_mode = false
	ultra_instinct_tint.visible = false
	player_position.visible = false


func _on_player_recorded_action(action_pair: Array) -> void:
	var begin = action_pair[0].frame
	var end = action_pair[1].frame
	var action = action_pair[0].action

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
		label_lines.push_back([])

		# no previous action on the current line
		prev_end = 0
	# if putting new action in a previous line, get last action on that line
	else:
		prev_end = action_lines[i].back()[1].frame
	action_lines[i].push_back(action_pair)

	# create new label inside a margin container at line i
	var margin_px_unscaled = begin - prev_end

	var label = Label.new()
	label.clip_text = true
	label.text = InputActions.to_str(action)
	label.add_theme_font_size_override("font_size", 32)
	playback_panel.add_child(label)

	label.offset_left = PLAYBACK_UI_PADDING_LEFT + (prev_end + margin_px_unscaled) * PLAYBACK_UI_SCALE_X
	label.offset_top = i * 52
	label.set_size(Vector2((end - begin) * PLAYBACK_UI_SCALE_X, 32))

	var style = StyleBoxFlat.new()
	style.bg_color.a = 0
	style.set_border_width_all(2)
	label.add_theme_stylebox_override("normal", style)
	label_lines[i].push_back(label)


func scroll_playback_ui_to_left(scroll_by_x: float) -> void:
	for line in label_lines:
		for label in line:
			label.offset_left -= scroll_by_x
			label.offset_right -= scroll_by_x


func intervals_overlap(b1: int, e1: int, b2: int, e2: int) -> bool:
	return not (e2 <= b1 or e1 <= b2)
