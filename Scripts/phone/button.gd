extends Node

signal button_press(number: String)
signal phone_call

func button0(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("0")
		emit_signal("button_press", "0")
	pass # Replace with function body.
	

func button1(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("1")
		emit_signal("button_press", "1")
	pass # Replace with function body.


func button2(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("2")
		emit_signal("button_press", "2")
	pass # Replace with function body.


func button3(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("3")
		emit_signal("button_press", "3")
	pass # Replace with function body.


func button4(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("4")
		emit_signal("button_press", "4")
	pass # Replace with function body.


func button5(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("5")
		emit_signal("button_press", "5")
	pass # Replace with function body.


func button6(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("6")
		emit_signal("button_press", "6")
	pass # Replace with function body.


func button7(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("7")
		emit_signal("button_press", "7")
	pass # Replace with function body.


func button8(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("8")
		emit_signal("button_press", "8")
	pass # Replace with function body.


func button9(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("9")
		emit_signal("button_press", "9")
	pass # Replace with function body.


func button_call(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("call")
		emit_signal("phone_call")
	pass # Replace with function body.
