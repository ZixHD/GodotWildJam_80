extends Node

@onready var documents: Node = $Documents
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var spawn: Marker2D = $Spawn
@onready var stamp: Node2D = $Stamp
@onready var hand_animator: AnimationPlayer = $Node2D/AnimationPlayer
@onready var timer: Timer = $Timer
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var paper_sound: AudioStreamPlayer = $PaperSound
@onready var stamp_sound: AudioStreamPlayer = $StampSound

const DOCUMENT_1 = preload("res://Scenes/documents/document_1.tscn")
const DOCUMENT_2 = preload("res://Scenes/documents/document_2.tscn")
const DOCUMENT_3 = preload("res://Scenes/documents/document_3.tscn")
const DOCUMENT_4 = preload("res://Scenes/documents/document_4.tscn")
const DOCUMENT_5 = preload("res://Scenes/documents/document_5.tscn")
const DOCUMENT_6 = preload("res://Scenes/documents/document_6.tscn")
const LMAG = preload("res://Scenes/documents/lmag.tscn")



var document_scenes = [
	DOCUMENT_1, DOCUMENT_2, DOCUMENT_3, DOCUMENT_4, DOCUMENT_5, DOCUMENT_6
]

signal game_finished
signal game_lost
var document_index = 0;
var document_count = document_scenes.size();
var current_document: Node2D = null
var spawn_flag = true;
var animator: AnimatedSprite2D;
var change_paper = false;
var total_time = 10
var shuffled_docs;

func _ready() -> void:	
	stamp.connect("add_mark_signal", Callable(self, "_on_add_mark_signal"))
	progress_bar.min_value = 0
	progress_bar.max_value = 100
	timer.start(total_time)
	shuffle_documents()
	
func shuffle_documents():
	shuffled_docs = document_scenes.duplicate()
	shuffled_docs.shuffle();
	
func _process(_delta: float) -> void:
	if spawn_flag and document_count != 0:
		spawn_document()
		
	if timer.time_left > 0:
		if(document_count == 0):
			timer.queue_free()
			progress_bar.queue_free()
			emit_signal("game_finished")
			return;
		progress_bar.value = (timer.time_left / total_time) * progress_bar.max_value
	else:
		progress_bar.value = 0
		
func spawn_document():
	
	spawn_flag = false;
	current_document = shuffled_docs[document_index].instantiate()
	current_document.global_position = spawn.global_position
	var collision = current_document.get_node("Area2D/CollisionShape2D")
	collision.disabled = false;
	current_document.lmag_placed.connect(_on_lmag_placed)
	documents.call_deferred("add_child", current_document)


func _on_lmag_placed():
	document_count-=1;
	hand_animator.play("default")
	await get_tree().create_timer(0.3).timeout 
	paper_sound.play()
	if(document_index + 1 < 6):
		document_index+=1;
	elif document_index == 6:
		return;

	current_document.queue_free()
	spawn_flag = true;
	
	
	
func _on_add_mark_signal(x_pos: int, y_pos: int) -> void:
	var mark: Node2D = LMAG.instantiate()
	mark.position = current_document.to_local(Vector2(x_pos, y_pos))
	stamp_sound.play()
	current_document.add_child(mark)


func _on_timer_timeout() -> void:
	if(document_count != 0):
		emit_signal("game_lost")
		
