extends Node

@onready var timer: Timer = $Timer
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var tutorial: TextureRect = $Tutorial
@onready var marker_0: Marker2D = $Markers/Marker0
@onready var marker_1: Marker2D = $Markers/Marker1
@onready var marker_2: Marker2D = $Markers/Marker2
@onready var marker_3: Marker2D = $Markers/Marker3
@onready var marker_4: Marker2D = $Markers/Marker4
@onready var marker_5: Marker2D = $Markers/Marker5
@onready var marker_6: Marker2D = $Markers/Marker6
@onready var marker_7: Marker2D = $Markers/Marker7
@onready var marker_8: Marker2D = $Markers/Marker8
@onready var marker_9: Marker2D = $Markers/Marker9
@onready var marker_call: Marker2D = $Markers/MarkerCall
@onready var number_texture: TextureRect = $Number

signal game_finished
signal game_lost
var button_scenes = [
	 preload("res://Scenes/phone/buttons/button_0.tscn"),
	 preload("res://Scenes/phone/buttons/button_1.tscn"),
	 preload("res://Scenes/phone/buttons/button_2.tscn"),
	 preload("res://Scenes/phone/buttons/button_3.tscn"),
	 preload("res://Scenes/phone/buttons/button_4.tscn"),
	 preload("res://Scenes/phone/buttons/button_5.tscn"),
	 preload("res://Scenes/phone/buttons/button_6.tscn"),
	 preload("res://Scenes/phone/buttons/button_7.tscn"),
	 preload("res://Scenes/phone/buttons/button_8.tscn"),
	 preload("res://Scenes/phone/buttons/button_9.tscn"),
	 preload("res://Scenes/phone/buttons/button_call.tscn"),
]

@onready var numbers = {
	"379147": preload("res://assets/phone calls/number1.png"),
	"490130": preload("res://assets/phone calls/number2.png"),
	"057269": preload("res://assets/phone calls/number3.png"),
	"625381": preload("res://assets/phone calls/number4.png"),
	"137257": preload("res://assets/phone calls/number5.png"),
}

@onready var markers = [
	marker_0, marker_1, marker_2, marker_3, marker_4, marker_5, marker_6, marker_7, marker_8, marker_9, marker_call
]


var total_time := 10.0  
var max_ads;
var game_end = false;
var input:String = ""
var random_number: Texture2D = null;
var calling_number: String = "";
var game_won:bool = false;

func _ready():
	_chooseNumber()
	_setUpButtons()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	await get_tree().create_timer(2).timeout;
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	tutorial.visible = false;
	progress_bar.visible = true;
	total_time *= GameManager.multiplyer
	progress_bar.min_value = 0
	progress_bar.max_value = 100
	timer.start(total_time)
	
func _process(_delta):
	if !game_end and timer.time_left > 0:
		if(game_won):
			await get_tree().create_timer(0.1).timeout;
			timer.queue_free()
			progress_bar.queue_free()
			game_end = true;
			emit_signal("game_finished")
			return;
		progress_bar.value = (timer.time_left / total_time) * progress_bar.max_value
	else:
		progress_bar.value = 0
		
func _setUpButtons() -> void:
	var length:int = button_scenes.size();
	for i in range(length):
		var bt:PackedScene = button_scenes[i];
		var marker:Marker2D = markers[i];
		var number:Node2D = bt.instantiate()
		if(i == 10):
			number.phone_call.connect(_on_phone_call)
		else:
			number.button_press.connect(_on_button_pressed)
		number.global_position = marker.global_position;
		add_child(number)
		
func _chooseNumber() ->void:
	var keys = numbers.keys()
	var random_key = keys[randi() % keys.size()]
	number_texture.texture = numbers[random_key]
	calling_number = random_key;
	print("Chosen number is: ", random_key)


func _on_button_pressed(number: String):
		input += number
		print("Input: ", input)
	
func _on_phone_call():
	if(calling_number == input):
		game_won = true;
	input = ""
	print("calling...")


func _on_timer_timeout() -> void:
	if(!game_won):
		emit_signal("game_lost")
