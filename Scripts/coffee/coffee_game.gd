extends Node

@onready var coffee_mug: AnimatedSprite2D = $CoffeeMug
@onready var coffee_flow: Sprite2D = $CoffeeFlow
@onready var timer: Timer = $Timer
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var tutorial: TextureRect = $Tutorial
@onready var coffee_stream: AudioStreamPlayer = $CoffeeStream
@onready var coffee_button: AudioStreamPlayer = $CoffeeButton


signal game_finished
signal game_lost
var frame_count;
var total_time :float = 10.0
var game_won = false;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	await get_tree().create_timer(2).timeout;
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	tutorial.visible = false;
	progress_bar.visible = true;
	coffee_mug.visible = true;
	total_time *= GameManager.multiplyer
	var frames: SpriteFrames = coffee_mug.sprite_frames
	frame_count = frames.get_frame_count("default")
	progress_bar.min_value = 0
	progress_bar.max_value = 100
	timer.start(total_time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
		
	if(coffee_mug.frame >= 59):
		emit_signal("game_lost")
		


func _on_go_pressed() -> void:
	coffee_flow.visible = true;
	coffee_button.play()
	coffee_mug.play("default")
	coffee_stream.play();
	


func _on_stop_pressed() -> void:
	var current_frame = coffee_mug.frame
	coffee_button.play()
	coffee_stream.stop()
	if(current_frame == 54 || current_frame == 55 || current_frame == 56):
		game_won = true;
	if(coffee_mug.is_playing()):
		coffee_flow.visible = false;
		coffee_mug.pause()


func _on_timer_timeout() -> void:
	if(!game_won):
		emit_signal("game_lost")
