extends Node

@onready var player: CharacterBody2D = $Player
@onready var timer: Timer = $Timer
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var tutorial: TextureRect = $Tutorial

signal game_finished
signal game_lost
var total_time :float = 10.0
var game_won;

func _ready() -> void:
	Input.warp_mouse(Vector2(630,533))
	await get_tree().create_timer(2).timeout;
	tutorial.visible = false;
	progress_bar.visible = true
	total_time *= GameManager.multiplyer
	progress_bar.min_value = 0
	progress_bar.max_value = 100
	timer.start(total_time)

func _process(_delta: float) -> void:
	if timer.time_left > 0:
		if(game_won):
			await get_tree().create_timer(0.1).timeout 
			timer.queue_free()
			progress_bar.queue_free()
			emit_signal("game_finished")
			return;
		progress_bar.value = (timer.time_left / total_time) * progress_bar.max_value
	else:
		progress_bar.value = 0
	guide_player()

func guide_player():
	player.global_position = get_viewport().get_mouse_position()
	
func _on_timer_timeout() -> void:
	if(!game_won):
		emit_signal("game_lost")


func _on_desk_1_body_entered(_body: Node2D) -> void:
	print("desk1")
	emit_signal("game_lost")


func _on_desk_2_body_entered(_body: Node2D) -> void:
	print("desk2")
	emit_signal("game_lost")


func _on_desk_3_body_entered(_body: Node2D) -> void:
	print("desk3")
	emit_signal("game_lost")


func _on_desk_4_body_entered(_body: Node2D) -> void:
	print("desk4")
	emit_signal("game_lost")

func _on_starting_wall_1_body_entered(_body: Node2D) -> void:
	print("sw1")
	emit_signal("game_lost")


func _on_starting_wall_2_body_entered(_body: Node2D) -> void:
	print("sw2")
	emit_signal("game_lost")


func _on_boss_body_entered(_body: Node2D) -> void:
	print("boss")
	game_won = true;
	emit_signal("game_finished")
