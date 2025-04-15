extends AudioStreamPlayer


@onready var audio_stream_player = $"."


func _ready():
	audio_stream_player.volume_db = 18;
