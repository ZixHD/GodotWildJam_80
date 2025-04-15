extends TextureButton

@onready var mute = $"."
@onready var audio_stream_player = %AudioStreamPlayer

var texture_unmuted: Texture2D = preload("res://assets/menu/mute.png")
var texture_muted: Texture2D = preload("res://assets/menu/mute2.png")
var checked = false;


func _on_pressed():
	
	if(!checked):
		audio_stream_player.volume_db = 18;
		audio_stream_player.play()
		await get_tree().create_timer(0.01).timeout
		mute.texture_normal = texture_muted;
	else:

		audio_stream_player.volume_db = -80
		mute.texture_normal = texture_unmuted;
		
	checked = !checked;
