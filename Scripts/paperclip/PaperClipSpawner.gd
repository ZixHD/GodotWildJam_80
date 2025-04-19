extends Node

@onready var spawn_1: Marker2D = $Markers/Spawn1
@onready var spawn_2: Marker2D = $Markers/Spawn2
@onready var spawn_3: Marker2D = $Markers/Spawn3
@onready var spawn_4: Marker2D = $Markers/Spawn4
@onready var spawn_5: Marker2D = $Markers/Spawn5
@onready var spawn_6: Marker2D = $Markers/Spawn6
@onready var timer: Timer = $PaperClips/Timer
@onready var progress_bar: ProgressBar = $PaperClips/ProgressBar
@onready var paperclip_sound: AudioStreamPlayer = $PaperclipSound
@onready var red_box_1: TextureRect = $RedBox1
@onready var red_box_2: TextureRect = $RedBox2
@onready var blue_box_1: TextureRect = $BlueBox1
@onready var blue_box_2: TextureRect = $BlueBox2
@onready var green_box_1: TextureRect = $GreenBox1
@onready var green_box_2: TextureRect = $GreenBox2
@onready var paper_clips: Node = $PaperClips
@onready var tutorial: TextureRect = $Tutorial

@onready var markers = [spawn_1, spawn_2, spawn_3, spawn_4, spawn_5, spawn_6]
@onready var boxes = [
	red_box_1, red_box_2, blue_box_1, blue_box_2, green_box_1, green_box_2
]

var clip_scenes = [
	preload("res://Scenes/paperclips/paper_clip1.tscn"),
	preload("res://Scenes/paperclips/paper_clip2.tscn"),
	preload("res://Scenes/paperclips/paper_clip3.tscn"),
	preload("res://Scenes/paperclips/paper_clip4.tscn"),
	preload("res://Scenes/paperclips/paper_clip5.tscn"),
	preload("res://Scenes/paperclips/paper_clip6.tscn")
]

signal game_finished
signal game_lost
var max_clips = 6
var total_time = 10.0
var game_end = false;

func _ready():
	await get_tree().create_timer(2).timeout;
	tutorial.visible = false;
	progress_bar.visible = true;
	total_time *= GameManager.multiplyer
	for box in boxes:
		box.connect("clip_placed", Callable(self, "_on_clip_placed"))
	max_clips = clip_scenes.size()
	progress_bar.min_value = 0
	progress_bar.max_value = 100
	timer.start(total_time)
	spawn_paperClips()
	
func _process(_delta: float) -> void:
	if timer.time_left > 0:
		progress_bar.value = (timer.time_left / total_time) * progress_bar.max_value
	else:
		progress_bar.value = 0


func spawn_paperClips():
	
	var shuffled_markers = markers.duplicate()
	shuffled_markers.shuffle()


	var clip_data = [
		{ "scene": clip_scenes[2], "color": Color(0, 0, 1) }, # Blue
		{ "scene": clip_scenes[3], "color": Color(0, 0, 1) },
		{ "scene": clip_scenes[4], "color": Color(0, 1, 0) }, # Green
		{ "scene": clip_scenes[5], "color": Color(0, 1, 0) },
		{ "scene": clip_scenes[0], "color": Color(1, 0, 0) }, # Red
		{ "scene": clip_scenes[1], "color": Color(1, 0, 0) },
	]
	
	
	for i in range(clip_data.size()):
		
		var clip: TextureRect = clip_scenes[i].instantiate()
		
		clip.global_position = shuffled_markers[i].global_position
		clip.clip_color = clip_data[i]["color"]
		clip.z_index = i
		add_child(clip)
		
func _on_clip_placed():
	paperclip_sound.play()
	max_clips -= 1
	print("Clip placed! Remaining clips:", max_clips)
	if max_clips == 0:
		print("All clips placed!")
		await get_tree().create_timer(0.1).timeout;
		emit_signal("game_finished")
		paper_clips.queue_free()
		
	

func _on_timer_timeout():
	if(max_clips > 0):
		emit_signal("game_lost")
	
	
