extends Node

@onready var coffee_mug: AnimatedSprite2D = $CoffeeMug
@onready var coffee_flow: Sprite2D = $CoffeeFlow
@onready var timer: Timer = $Timer
@onready var progress_bar: ProgressBar = $ProgressBar

var frame_count;
var total_time := 10.0  
var game_won = false;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var frames: SpriteFrames = coffee_mug.sprite_frames
	frame_count = frames.get_frame_count("default")
	progress_bar.min_value = 0
	progress_bar.max_value = 100
	timer.start(total_time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer.time_left > 0:
		if(game_won):
			timer.stop()
		progress_bar.value = (timer.time_left / total_time) * progress_bar.max_value
	else:
		progress_bar.value = 0


func _on_go_pressed() -> void:
	coffee_flow.visible = true;
	coffee_mug.play("default")
	if(coffee_mug.animation_finished):
		print("End")
	


func _on_stop_pressed() -> void:
	var current_frame = coffee_mug.frame
	if(current_frame == 54 || current_frame == 55 || current_frame == 56 ):
		print("pobeda")
		game_won = true;
	if(coffee_mug.is_playing()):
		coffee_flow.visible = false;
		coffee_mug.pause()


func _on_timer_timeout() -> void:
	if(!game_won):
		print("Isteklo je vreme")
