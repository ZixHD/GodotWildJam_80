extends TextureRect



var clip_color: Color;
var can_drag := true
var original_texture: Texture2D
var drag_success := false


func _get_drag_data(at_position):
	if !can_drag or texture == null:
		return null

	original_texture = texture
	drag_success = false  # Reset this at start of drag

	var preview_texture = TextureRect.new()
	preview_texture.texture = texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(60, 70)

	var preview = Control.new()
	preview.add_child(preview_texture)

	set_drag_preview(preview)

	var drag_data = {
		"texture": texture,
		"source": self
	}

	texture = null  # Clear the texture for visual feedback
	return drag_data



func _notification(what):
	if what == NOTIFICATION_DRAG_END:
		# Drag ended, check if drop was successful
		if !drag_success and texture == null and original_texture != null:
			texture = original_texture
