extends Node
@onready var score_screen: TextureRect = $ScoreScreen
@onready var game_over: TextureRect = $GameOver
@onready var hearts: AnimatedSprite2D = $Hearts
@onready var label: Label = $Label
@onready var return_to_menu: TextureButton = $ReturnToMenu
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

const MENU = preload("res://Scenes/menu/menu.tscn")
var heart_frames;

func _ready() -> void:
	heart_frames = hearts.sprite_frames
	select_sprite()
	label.text = str(GameManager.points)

func select_sprite():
	var health = GameManager.health
	if(health == 0):
		score_screen.visible = false;
		game_over.visible = true;
		return_to_menu.visible = true;
		
	hearts.frame = GameManager.health


func _on_return_to_menu_pressed() -> void:
	print("return")
	audio_stream_player.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_packed(MENU)
