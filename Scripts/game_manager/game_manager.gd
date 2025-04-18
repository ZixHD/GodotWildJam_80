extends Node

var health = 3
const AD_GAME = preload("res://Scenes/ads/desktop.tscn")
const COFFEE_GAME = preload("res://Scenes/coffee/coffee_game.tscn")
const STAMP_GAME = preload("res://Scenes/documents/stamp_game.tscn")
const PAPER_CLIP_GAME = preload("res://Scenes/paperclips/paperClipGame.tscn")


var game_array = [
	AD_GAME, COFFEE_GAME, STAMP_GAME, PAPER_CLIP_GAME
]
var shuffled_games = []
var current_game_index = 0
var current_game_instance: Node = null

func _ready() -> void:
	shuffle_games()

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("space")):
		current_game_index += 1
		start_game()

func start_game():
	if current_game_instance:
		current_game_instance.queue_free()

	if current_game_index >= shuffled_games.size():
		shuffle_games()
		current_game_index = 0;
		
	var game_scene: PackedScene = shuffled_games[current_game_index]
	current_game_instance = game_scene.instantiate()
	add_child(current_game_instance)
	
	current_game_instance.connect("game_finished", Callable(self, "_on_game_finished"))
	current_game_instance.connect("game_lost", Callable(self, "_on_game_lost"))


func shuffle_games():
	shuffled_games = game_array.duplicate();
	shuffled_games.shuffle()
	
func _on_game_finished():
	remove_child(current_game_instance)
	current_game_index += 1
	start_game()
	
func _on_game_lost():
	if(health > 0):
		health -=1
		print("Lost 1hp")
		if(health == 0):
			print("You lost")
		else:
			current_game_index += 1
			start_game()
	
