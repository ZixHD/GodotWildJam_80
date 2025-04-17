extends Node2D

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var stamp_node: Node2D = $"."  # This stamp node itself
@onready var stamp := self

const LMAG = preload("res://Scenes/documents/lmag.tscn")

signal add_mark_signal(x_pos, y_pos)

var glide_base_duration := 2.0
var glide_distance := 550
var press_depth := 300
var is_gliding := true
var is_pressing := false
var direction := 1  

var start_position: int
var end_position: int
var target_x;
var tween: Tween

func _ready():
	start_position = stamp.global_position.x
	end_position = stamp.global_position.x + glide_distance
	start_glide()

func _input(event):
	if event.is_action_pressed("click") and !is_pressing:
		press_stamp()

func start_glide():
	is_gliding = true
	var current_x = stamp.position.x
	target_x = current_x + (end_position - current_x)  if direction == 1 else current_x - (current_x - start_position)

	var distance_to_travel = abs(target_x - current_x)
	var glide_duration = distance_to_travel / glide_distance * glide_base_duration
	
	if tween: tween.kill()
	tween = create_tween()
	tween.tween_property(
		stamp,
		"position:x",
		target_x,
		glide_duration
	).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(Callable(self, "_on_glide_end"))

func _on_glide_end():
	direction *= -1
	start_glide()

func press_stamp():
	if !is_gliding:
		return

	is_pressing = true
	is_gliding = false
	if tween: tween.kill()

	var original_y = stamp.position.y

	var press_tween = create_tween()
	press_tween.tween_property(
		stamp,
		"position:y",
		original_y + press_depth,
		0.2
	).set_trans(Tween.TRANS_LINEAR)
	
	press_tween.tween_callback(Callable(self, "add_mark").bind(stamp_node.position.x - 60, press_depth + 100))
	
	press_tween.tween_property(
		stamp,
		"position:y",
		original_y,
		0.2
	).set_trans(Tween.TRANS_LINEAR)

	# Connect press done to add the mark after press animation completes
	press_tween.connect("finished", Callable(self, "_on_press_done"))

func _on_press_done():
	# Now add the mark after the press is done
	is_pressing = false
	start_glide()

func add_mark(x_pos: int, y_pos: int):
	emit_signal("add_mark_signal",x_pos, y_pos)
	
