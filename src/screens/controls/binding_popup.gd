extends Popup

signal key_pressed(action, input, scancode)

var current_action
var current_input

func _ready():
	set_process_input(true)

func popup_binding(action, input):
	current_action = action
	current_input = input
	popup_centered()

func _input(event):
	if(visible && event.type == InputEvent.KEY && event.pressed):
		emit_signal("key_pressed", current_action, current_input, event.scancode)
