extends Node


@onready var timer: Timer = $Timer
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var tutorial: TextureRect = $Tutorial
@onready var player: CharacterBody2D = $Player
@onready var sw_1: CollisionPolygon2D = $CollisionObjects/StartingWall1/SW1
@onready var sw_2: CollisionPolygon2D = $CollisionObjects/StartingWall2/SW2
@onready var b_1: CollisionShape2D = $Boss/B1
@onready var p_1: CollisionShape2D = $Player/P1
@onready var f_1: CollisionShape2D = $CollisionObjects/RandomObjects/Flower1/F1
@onready var f_2: CollisionShape2D = $CollisionObjects/RandomObjects/Flower2/F2
@onready var f_3: CollisionShape2D = $CollisionObjects/RandomObjects/Flower3/F3
@onready var f_4: CollisionShape2D = $CollisionObjects/RandomObjects/Flower4/F4
@onready var f_5: CollisionShape2D = $CollisionObjects/RandomObjects/Flower5/F5
@onready var c_1: CollisionShape2D = $CollisionObjects/RandomObjects/Chair1/C1
@onready var c_2: CollisionShape2D = $CollisionObjects/RandomObjects/Chair2/C2
@onready var c_3: CollisionShape2D = $CollisionObjects/RandomObjects/Chair3/C3
@onready var fw_1: CollisionPolygon2D = $CollisionObjects/FinishWall1/FW1
@onready var fw_2: CollisionPolygon2D = $CollisionObjects/FinishWall2/FW2

signal game_finished
signal game_lost
var total_time :float = 10.0
var game_won;

func _ready() -> void:
	set_collisions_off()
	await get_tree().create_timer(2).timeout;
	tutorial.visible = false;
	progress_bar.visible = true
	total_time *= GameManager.multiplyer
	progress_bar.min_value = 0
	progress_bar.max_value = 100
	set_collisions_on()
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
	
	
func set_collisions_on():
	sw_1.disabled = false;
	sw_2.disabled = false;
	b_1.disabled = false;
	p_1.disabled = false;
	f_1.disabled = false;
	f_2.disabled = false;
	f_3.disabled = false;
	f_4.disabled = false;
	f_5.disabled = false;
	c_1.disabled = false;
	c_2.disabled = false;
	c_3.disabled = false;
	fw_1.disabled = false;
	fw_2.disabled = false;
func set_collisions_off():
	sw_1.disabled = true;
	sw_2.disabled = true;
	b_1.disabled = true;
	p_1.disabled = true
	f_1.disabled = true;
	f_2.disabled = true;
	f_3.disabled = true;
	f_4.disabled = true;
	f_5.disabled = true;
	c_1.disabled = true;
	c_2.disabled = true;
	c_3.disabled = true;
	fw_1.disabled = true;
	fw_2.disabled = true;
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


func _on_flower_1_body_entered(body: Node2D) -> void:
	print("f1")
	emit_signal("game_lost")



func _on_flower_2_body_entered(body: Node2D) -> void:
	print("f2")
	emit_signal("game_lost")
 # Replace with function body.


func _on_flower_3_body_entered(body: Node2D) -> void:
	print("f3")
	emit_signal("game_lost")
 # Replace with function body.


func _on_flower_4_body_entered(body: Node2D) -> void:
	print("f4")
	emit_signal("game_lost")
 # Replace with function body.


func _on_flower_5_body_entered(body: Node2D) -> void:
	print("f5")
	emit_signal("game_lost")
 # Replace with function body.


func _on_chair_1_body_entered(body: Node2D) -> void:
	print("c1")
	emit_signal("game_lost")
 # Replace with function body.


func _on_chair_2_body_entered(body: Node2D) -> void:
	print("c2")
	emit_signal("game_lost")
 # Replace with function body.


func _on_chair_3_body_entered(body: Node2D) -> void:
	print("c3")
	emit_signal("game_lost")
 # Replace with function body.

func _on_finish_wall_1_body_entered(body: Node2D) -> void:
	print("fw1")
	emit_signal("game_lost")


func _on_finish_wall_2_body_entered(body: Node2D) -> void:
	print("fw2")
	emit_signal("game_lost")
