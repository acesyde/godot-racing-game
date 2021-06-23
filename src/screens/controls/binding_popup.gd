extends Popup

signal key_pressed(action, input, scancode)

var current_action
var current_input

func _ready():
	set_process_input(true)

func popup_binding(action: String, input: int):
	current_action = action
	current_input = input
	popup_centered()

func _input(event: InputEvent):
	if event is InputEventKey:
		if(visible && event.is_pressed()):
			emit_signal("key_pressed", current_action, current_input, event.scancode)
