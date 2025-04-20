extends TextureRect

@onready var red_box_1 = $"."
@onready var red_box_2 = $"../RedBox2"
@onready var blue_box_1 = $"../BlueBox1"
@onready var blue_box_2 = $"../BlueBox2"
@onready var green_box_1 = $"../GreenBox1"
@onready var green_box_2 = $"../GreenBox2"

signal clip_placed
var accepted_color: Color;
var can_drag := true
var original_texture: Texture2D
var drag_success := false

func _ready():
	red_box_1.accepted_color = Color(1, 0, 0)    # Red
	red_box_2.accepted_color = Color(1, 0, 0)

	blue_box_1.accepted_color = Color(0, 0, 1)   # Blue
	blue_box_2.accepted_color = Color(0, 0, 1)

	green_box_1.accepted_color = Color(0, 1, 0)  # Green
	green_box_2.accepted_color = Color(0, 1, 0)
	


func _can_drop_data(_at_position, data):
	return typeof(data) == TYPE_DICTIONARY and data.has("texture") and data["texture"] is Texture2D

func _drop_data(_at_position, data):
	if texture != null:
		return 
	#print("BoxColor", accepted_color)
	#print("ClipColor", data["source"].clip_color)
	if accepted_color != data["source"].clip_color:
		return  # Wrong color, reject drop
		
	texture = data["texture"]
	data["source"].can_drag = false
	data["source"].drag_success = true  
	if data["source"] != self:
		emit_signal("clip_placed")
		data["source"].queue_free()

func _notification(what):
	if what == NOTIFICATION_DRAG_END:
		if !drag_success and texture == null and original_texture != null:
			texture = original_texture
