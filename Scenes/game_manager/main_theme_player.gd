extends Node

@onready var music_player = $MainThemePlayer

func _ready():
	if not music_player.playing:
		music_player.play()
func _on_MainThemePlayer_finished():
	music_player.play()
