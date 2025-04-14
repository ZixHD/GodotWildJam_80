extends TextureButton

@onready var mute = $"."

var texture_unmuted: Texture2D = preload("res://assets/menu/mute.png")
var texture_muted: Texture2D = preload("res://assets/menu/mute2.png")
var checked = false;

func _process(delta):
	if(!checked):
		mute.texture_normal = texture_unmuted;
	else:
		mute.texture_normal = texture_muted;
func _on_pressed():
	checked = !checked;
