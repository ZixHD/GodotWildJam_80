extends Node
@onready var danger_1: Sprite2D = $Danger
@onready var danger_2: Sprite2D = $Danger2
@onready var danger_3: Sprite2D = $Danger3
@onready var boss: AnimatedSprite2D = $Boss
@onready var monitor: AnimatedSprite2D = $Monitor
@onready var timer: Timer = $Timer
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var boss_timer: Timer = $Boss/BossTimer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var tutorial: TextureRect = $Tutorial
@onready var boss_sound: AudioStreamPlayer = $BossSound



signal game_finished
signal game_lost
var current_frame = 1;
var frames;
var frame_count;
var mouse_inside = false;
var points = 0;
var total_time := 10.0  
var scares = [
	2.0, 1.0, 1.5, 2.5, 1.0
]
var scares_dup = []
var scares_index = 0;
var boss_frames;
var boss_current_frame = 0
var game_over = false;
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	await get_tree().create_timer(2).timeout;
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	tutorial.visible = false;
	progress_bar.visible = true;
	total_time *= GameManager.multiplyer
	scares_dup = scares.duplicate();
	scares_dup.shuffle();
	frames = monitor.sprite_frames
	frame_count = frames.get_frame_count("default")
	boss_frames = boss.sprite_frames;
	danger_1.visible = false;
	danger_2.visible = false;
	danger_3.visible = false;
	progress_bar.min_value = 0
	progress_bar.max_value = 100
	timer.start(total_time)
	boss_timer.start(scares_dup[scares_index])
	
func _process(_delta: float) -> void:
	if mouse_inside:
		click()
	if timer.time_left > 0:
		progress_bar.value = (timer.time_left / total_time) * progress_bar.max_value
	else:
		progress_bar.value = 0
		
		
func click():
	if(Input.is_action_just_pressed("click")):
			audio_stream_player.play()
			points += 2;
			current_frame = (current_frame + 1) % frame_count
			if(current_frame == 0):
				current_frame += 1;
			monitor.frame = current_frame
func _on_area_2d_mouse_entered() -> void:
	mouse_inside = true;
	monitor.frame = current_frame
	
func _on_area_2d_mouse_exited() -> void:
	mouse_inside = false
	monitor.frame = 0

func _on_timer_timeout() -> void:
	GameManager.points += points;
	emit_signal("game_finished")
	timer.queue_free()
	progress_bar.queue_free()


func _on_boss_timer_timeout() -> void:
	if(scares_index + 1 <= scares_dup.size()):
		var scare_delay = scares_dup[scares_index]
		await get_tree().create_timer(scare_delay - 0.5).timeout
		danger_1.visible = true;
		danger_2.visible = true;
		danger_3.visible = true;
		await get_tree().create_timer(0.5).timeout
		danger_1.visible = false;
		danger_2.visible = false;
		danger_3.visible = false;
		boss_current_frame = 1;
		boss.frame = boss_current_frame
		boss_timer.wait_time = scare_delay
		boss_sound.play()
		if mouse_inside:
			await get_tree().create_timer(0.3).timeout
			emit_signal("game_lost")
			queue_free()
			return
		scares_index += 1;
		await get_tree().create_timer(0.5).timeout
		boss_current_frame = 0;
		boss.frame = boss_current_frame
		boss_timer.start()
