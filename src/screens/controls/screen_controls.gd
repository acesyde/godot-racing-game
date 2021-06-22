extends "../abstract_screen.gd"

#--------------
# Variables
#--------------
var move_up_inputs: HBoxContainer
var move_down_inputs: HBoxContainer
var move_left_inputs: HBoxContainer
var move_right_inputs: HBoxContainer

var binding_popup: Popup

func _ready():
	move_up_inputs = find_node("move_up_inputs")
	move_down_inputs = find_node("move_down_inputs")
	move_left_inputs = find_node("move_left_inputs")
	move_right_inputs = find_node("move_right_inputs")
	binding_popup = find_node("binding_popup")
	binding_popup.set_focus_mode(Control.FOCUS_ALL)
	_load_inputs()

func _load_inputs():
	var fmt = "Key %s"
	
	move_up_inputs.get_children().clear()
	var inputs = UserSettings.get_keybindings("move_up")
	for input in inputs:
		var button = Button.new()
		button.text = fmt % UserSettings.convert_key_to_string(input.scancode)
		button.connect("pressed", self, "_on_move_up_inputs_button_selected",[0])
		move_up_inputs.add_child(button)
		
	move_down_inputs.get_children().clear()
	inputs = UserSettings.get_keybindings("move_down")
	for input in inputs:
		var button = Button.new()
		button.text = fmt % UserSettings.convert_key_to_string(input.scancode)
		button.connect("pressed", self, "_on_move_down_inputs_button_selected",[1])
		move_up_inputs.add_child(button)
		
	move_left_inputs.get_children().clear()
	inputs = UserSettings.get_keybindings("move_left")
	for input in inputs:
		var button = Button.new()
		button.text = fmt % UserSettings.convert_key_to_string(input.scancode)
		button.connect("pressed", self, "_on_move_left_inputs_button_selected",[2])
		move_up_inputs.add_child(button)
		
	move_right_inputs.get_children().clear()
	inputs = UserSettings.get_keybindings("move_right")
	for input in inputs:
		var button = Button.new()
		button.text = fmt % UserSettings.convert_key_to_string(input.scancode)
		button.connect("pressed", self, "_on_move_right_inputs_button_selected",[3])
		move_up_inputs.add_child(button)

func _on_back_pressed():
	emit_signal("next_screen", "main_menu")

func _on_move_up_inputs_button_selected( button_idx ):
	binding_popup.popup_binding("move_up", button_idx)

func _on_move_down_inputs_button_selected( button_idx ):
	binding_popup.popup_binding("move_down", button_idx)

func _on_move_left_inputs_button_selected( button_idx ):
	binding_popup.popup_binding("move_left", button_idx)

func _on_move_right_inputs_button_selected( button_idx ):
	binding_popup.popup_binding("move_right", button_idx)

func _on_cancel_pressed():
	binding_popup.visible = true

func _on_binding_popup_key_pressed( action, input, scancode ):
	UserSettings.replace_keybinding(action, input, scancode)
	_load_inputs()
	binding_popup.visible = false
