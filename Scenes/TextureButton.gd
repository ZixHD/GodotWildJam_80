extends TextureButton

@onready var texture_button = $"."
@onready var animation_player = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("idle");
