extends Node

@onready var audio_stream_player = %AudioStreamPlayer
@onready var menu: Node = $"."
@onready var texture_button_1: TextureButton = $TextureRect/VBoxContainer/TextureButton1
@onready var texture_button_2: TextureButton = $TextureRect/VBoxContainer/TextureButton2
@onready var animation_player_1: AnimationPlayer = $TextureRect/VBoxContainer/TextureButton1/AnimationPlayer1
@onready var animation_player_2: AnimationPlayer = $TextureRect/VBoxContainer/TextureButton2/AnimationPlayer2


func _ready():
	animation_player_1.play("idle");
	animation_player_2.play("idle");

func _on_texture_button_1_pressed() -> void:
	audio_stream_player.play()
	await get_tree().create_timer(0.2).timeout
	GameManager.start_game();
	GameManager.interlude = true;
	menu.queue_free()


func _on_texture_button_2_pressed() -> void:
	audio_stream_player.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().quit(0)
