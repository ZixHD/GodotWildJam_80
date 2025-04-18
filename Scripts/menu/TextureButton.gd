extends TextureButton

@onready var texture_button = $"."
@onready var animation_player = $AnimationPlayer
@onready var audio_stream_player = %AudioStreamPlayer
@onready var menu: Node = $"../../.."


# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("idle");

		#
func _on_pressed_play():
	audio_stream_player.play()
	await get_tree().create_timer(0.2).timeout
	GameManager.start_game();
	menu.queue_free()
	#get_tree().change_scene_to_file("res://Scenes/menu/desktop.tscn")
	

func _on_pressed_quit():
	audio_stream_player.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().quit(0)
