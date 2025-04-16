extends Node

@onready var spawn_1 = $"../Markers/Spawn1"
@onready var spawn_2 = $"../Markers/Spawn2"
@onready var spawn_3 = $"../Markers/Spawn3"
@onready var spawn_4 = $"../Markers/Spawn4"
@onready var spawn_5 = $"../Markers/Spawn5"
@onready var spawn_6 = $"../Markers/Spawn6"

@onready var markers = [spawn_1, spawn_2, spawn_3, spawn_4, spawn_5, spawn_6]
var ad_scenes = [
	preload("res://Scenes/ad_1.tscn"),
	preload("res://Scenes/ad_2.tscn"),
	preload("res://Scenes/ad_3.tscn"),
	preload("res://Scenes/ad_4.tscn"),
	preload("res://Scenes/ad_5.tscn"),
	preload("res://Scenes/ad_6.tscn")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	
	spawn_ad()

# Function to spawn an ad inside the defined area
func spawn_ad():
	var shuffled_markers = markers.duplicate()
	var shuffled_ads = ad_scenes.duplicate()
	shuffled_markers.shuffle()
	shuffled_ads.shuffle()

	for i in range(min(shuffled_markers.size(), shuffled_ads.size())):
		var ad = shuffled_ads[i].instantiate()
		ad.global_position = shuffled_markers[i].global_position
		add_child(ad)
	



