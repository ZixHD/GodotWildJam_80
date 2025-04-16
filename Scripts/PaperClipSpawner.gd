extends Node

@onready var spawn_1 = $"../Markers/Spawn1"
@onready var spawn_2 = $"../Markers/Spawn2"
@onready var spawn_3 = $"../Markers/Spawn3"
@onready var spawn_4 = $"../Markers/Spawn4"
@onready var spawn_5 = $"../Markers/Spawn5"
@onready var spawn_6 = $"../Markers/Spawn6"

@onready var markers = [spawn_1, spawn_2, spawn_3, spawn_4, spawn_5, spawn_6]


var clip_scenes = [
	preload("res://Scenes/paperClips/paper_clip1.tscn"),
	preload("res://Scenes/paperClips/paper_clip2.tscn"),
	preload("res://Scenes/paperClips/paper_clip3.tscn"),
	preload("res://Scenes/paperClips/paper_clip4.tscn"),
	preload("res://Scenes/paperClips/paper_clip5.tscn"),
	preload("res://Scenes/paperClips/paper_clip6.tscn")
]


func _ready():
	spawn_paperClips()


func spawn_paperClips():
	
	var shuffled_markers = markers.duplicate()
	shuffled_markers.shuffle()

	#color-map
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
		#ad.ad_closed.connect(_on_ad_closed)
		clip.z_index = i
		add_child(clip)
		
