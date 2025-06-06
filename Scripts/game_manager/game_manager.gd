extends Node

@onready var sountrack: AudioStreamPlayer = $Sountrack

const AD_GAME = preload("res://Scenes/ads/desktop.tscn")
const COFFEE_GAME = preload("res://Scenes/coffee/coffee_game.tscn")
const STAMP_GAME = preload("res://Scenes/documents/stamp_game.tscn")
const PAPER_CLIP_GAME = preload("res://Scenes/paperclips/paperClipGame.tscn")
const BOSS_GAME = preload("res://Scenes/boss/boss_game.tscn")
const HEALTH = preload("res://Scenes/health/health.tscn")
const LABYRINTH = preload("res://Scenes/labyrinth/labyrinth.tscn")
const PHONE_GAME = preload("res://Scenes/phone/phone_game.tscn")
var health = 3
var points = 0;
var multiplyer = 1;
var highscore = 0;
var health_scene_instance: Node = null
var game_array = [
	 AD_GAME, COFFEE_GAME, STAMP_GAME, PAPER_CLIP_GAME, BOSS_GAME, LABYRINTH, PHONE_GAME
]
var shuffled_games = []
var current_game_index = 0
var current_game_instance: Node = null
var interlude = false;

func _ready() -> void:
	shuffle_games()
	sountrack.play()

func start_game():
	if current_game_instance:
		current_game_instance.queue_free()

	if current_game_index >= shuffled_games.size():
		shuffle_games()
		current_game_index = 0;
		multiplyer -= 0.1
	if interlude:
		var health_scene = HEALTH.instantiate();
		add_child(health_scene)
		await get_tree().create_timer(2).timeout
		remove_child(health_scene)
		
	var game_scene: PackedScene = shuffled_games[current_game_index]
	current_game_instance = game_scene.instantiate()
	add_child(current_game_instance)
	
	current_game_instance.connect("game_finished", Callable(self, "_on_game_finished"))
	current_game_instance.connect("game_lost", Callable(self, "_on_game_lost"))


func shuffle_games():
	shuffled_games = game_array.duplicate();
	shuffled_games.shuffle()
	
func _on_game_finished():
	if is_instance_valid(current_game_instance) and current_game_instance.get_parent() == self:
		remove_child(current_game_instance)
	points += 100
	print("Point: ", points)
	current_game_index += 1
	start_game()
	
func _on_game_lost():
	if(health > 0):
		health -=1
		print("Lost 1hp")
		if(health == 0):
			if(points > highscore):
				highscore = points;
			if is_instance_valid(current_game_instance) and current_game_instance.get_parent() == self:
				remove_child(current_game_instance)
			health_scene_instance = HEALTH.instantiate()
			add_child(health_scene_instance)
		else:
			current_game_index += 1
			start_game()

func reset_game():
	if health_scene_instance:
		call_deferred("remove_child", health_scene_instance)
		health_scene_instance.queue_free()
		health_scene_instance = null

	shuffle_games()
	current_game_index = 0;
	health = 3
	points = 0;
	multiplyer = 1;
	interlude = false;
