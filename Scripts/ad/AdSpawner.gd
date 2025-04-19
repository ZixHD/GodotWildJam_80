extends Node

@onready var spawn_1: Marker2D = $Markers/Spawn1
@onready var spawn_2: Marker2D = $Markers/Spawn2
@onready var spawn_3: Marker2D = $Markers/Spawn3
@onready var spawn_4: Marker2D = $Markers/Spawn4
@onready var spawn_5: Marker2D = $Markers/Spawn5
@onready var spawn_6: Marker2D = $Markers/Spawn6
@onready var timer: Timer = $Timer
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var tutorial: TextureRect = $Tutorial

@onready var markers = [spawn_1, spawn_2, spawn_3, spawn_4, spawn_5, spawn_6]


signal game_finished
signal game_lost
var ad_scenes = [
	preload("res://Scenes/ads/ad_1.tscn"),
	preload("res://Scenes/ads/ad_2.tscn"),
	preload("res://Scenes/ads/ad_3.tscn"),
	preload("res://Scenes/ads/ad_4.tscn"),
	preload("res://Scenes/ads/ad_5.tscn"),
	preload("res://Scenes/ads/ad_6.tscn")
]

var total_time := 10.0  
var max_ads;
var game_end = false;


func _process(_delta):
	if !game_end and timer.time_left > 0:
		if(max_ads == 0):
			await get_tree().create_timer(0.1).timeout;
			timer.queue_free()
			progress_bar.queue_free()
			game_end = true;
			emit_signal("game_finished")
			return;
		progress_bar.value = (timer.time_left / total_time) * progress_bar.max_value
	else:
		progress_bar.value = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(2).timeout;
	tutorial.visible = false;
	progress_bar.visible = true;
	total_time *= GameManager.multiplyer
	max_ads = ad_scenes.size();
	progress_bar.min_value = 0
	progress_bar.max_value = 100
	timer.start(total_time)
	spawn_ad()

# Function to spawn an ad inside the defined area
func spawn_ad():
	var shuffled_markers = markers.duplicate()
	var shuffled_ads = ad_scenes.duplicate()
	shuffled_markers.shuffle()
	shuffled_ads.shuffle()

	for i in range(min(shuffled_markers.size(), shuffled_ads.size())):
		var ad: Node2D = shuffled_ads[i].instantiate()
		ad.global_position = shuffled_markers[i].global_position
		ad.ad_closed.connect(_on_ad_closed)
		ad.z_index = i
		add_child(ad)
	

func _on_ad_closed():
	max_ads -= 1
	audio_stream_player.play()
	print("Ad closed! Remaining ads:", max_ads)
	
func _on_timer_timeout():
	if(max_ads != 0):
		emit_signal("game_lost")
