extends Node

@onready var texture_rect_1: TextureRect = $TextureRect1
@onready var texture_rect_2: TextureRect = $TextureRect2
@onready var hearts: AnimatedSprite2D = $Hearts
@onready var label: Label = $Label

var heart_frames;
func _ready() -> void:
	heart_frames = hearts.sprite_frames
	select_sprite()
	label.text = str(GameManager.points)

func select_sprite():
	var health = GameManager.health
	if(health == 0):
		texture_rect_1.visible = false;
		texture_rect_2.visible = true
	hearts.frame = GameManager.health
