extends "../abstract_screen.gd"

#--------------
# Variables
#--------------
var move_up_inputs: Button
var move_down_inputs: Button
var move_left_inputs: Button
var move_right_inputs: Button

var binding_popup: Popup

func _ready():
	move_up_inputs = find_node("move_up_inputs").get_child(1)
	move_down_inputs = find_node("move_down_inputs").get_child(1)
	move_left_inputs = find_node("move_left_inputs").get_child(1)
	move_right_inputs = find_node("move_right_inputs").get_child(1)
	binding_popup = find_node("binding_popup")
	binding_popup.set_focus_mode(Control.FOCUS_ALL)
	_load_inputs()

func _load_inputs():
	var fmt = "Key %s"
	
	var inputs = UserSettings.get_keybindings("move_up")
	for input in inputs:
		var button = Button.new()
		move_up_inputs.text = fmt % UserSettings.convert_key_to_string(input.scancode)
		move_up_inputs.connect("pressed", self, "_on_move_up_inputs_button_selected",[0])
		
	inputs = UserSettings.get_keybindings("move_down")
	for input in inputs:
		var button = Button.new()
		move_down_inputs.text = fmt % UserSettings.convert_key_to_string(input.scancode)
		move_down_inputs.connect("pressed", self, "_on_move_down_inputs_button_selected",[0])
		
	inputs = UserSettings.get_keybindings("move_left")
	for input in inputs:
		move_left_inputs.text = fmt % UserSettings.convert_key_to_string(input.scancode)
		move_left_inputs.connect("pressed", self, "_on_move_left_inputs_button_selected",[0])
		
	inputs = UserSettings.get_keybindings("move_right")
	for input in inputs:
		move_right_inputs.text = fmt % UserSettings.convert_key_to_string(input.scancode)
		move_right_inputs.connect("pressed", self, "_on_move_right_inputs_button_selected",[0])


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
