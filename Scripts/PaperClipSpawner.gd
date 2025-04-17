extends Node

@onready var spawn_1 = $"../Markers/Spawn1"
@onready var spawn_2 = $"../Markers/Spawn2"
@onready var spawn_3 = $"../Markers/Spawn3"
@onready var spawn_4 = $"../Markers/Spawn4"
@onready var spawn_5 = $"../Markers/Spawn5"
@onready var spawn_6 = $"../Markers/Spawn6"
@onready var timer = $Timer
@onready var progress_bar = $ProgressBar


@onready var markers = [spawn_1, spawn_2, spawn_3, spawn_4, spawn_5, spawn_6]
@onready var red_box_1 = $"../RedBox1"
@onready var red_box_2 = $"../RedBox2"
@onready var blue_box_1 = $"../BlueBox1"
@onready var blue_box_2 = $"../BlueBox2"
@onready var green_box_1 = $"../GreenBox1"
@onready var green_box_2 = $"../GreenBox2"

@onready var boxes = [
	red_box_1, red_box_2, blue_box_1, blue_box_2, green_box_1, green_box_2
]

var clip_scenes = [
	preload("res://Scenes/paperClips/paper_clip1.tscn"),
	preload("res://Scenes/paperClips/paper_clip2.tscn"),
	preload("res://Scenes/paperClips/paper_clip3.tscn"),
	preload("res://Scenes/paperClips/paper_clip4.tscn"),
	preload("res://Scenes/paperClips/paper_clip5.tscn"),
	preload("res://Scenes/paperClips/paper_clip6.tscn")
]

var max_clips = 6
var total_time = 10.0

func _ready():
	
	for box in boxes:
		box.connect("clip_placed", Callable(self, "_on_clip_placed"))
	max_clips = clip_scenes.size()
	progress_bar.min_value = 0
	progress_bar.max_value = 100
	timer.start(total_time)
	spawn_paperClips()
	
func _process(delta):
	if timer.time_left > 0:
		if(max_clips == 0):
			timer.stop()
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
	max_clips -= 1
	print("Clip placed! Remaining clips:", max_clips)
	

func _on_timer_timeout():
	if(max_clips != 0):
		print("Isteklo vreme")
	
