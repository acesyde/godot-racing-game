#############################################################
################ User settings singleton ####################
#############################################################

extends Node

#--------------
# Constants
#--------------
const USER_SETTINGS_PATH: String = "user://user_settings.cfg"
const KEY_BINDING_SECTION: String = "key_binding"

#--------------
# Variables
#--------------
var _user_settings: ConfigFile

func _ready():
	load_settings()
	if not _user_settings.has_section(KEY_BINDING_SECTION):
		_create_default_key_bindings()
	_load_key_bindings()

func load_settings():
	# We create an empty file if not present to avoid error while loading settings
	var file = File.new()
	if not file.file_exists(USER_SETTINGS_PATH):
		file.open(USER_SETTINGS_PATH, file.WRITE)
		file.close()
	
	_user_settings = ConfigFile.new()
	var err = _user_settings.load(USER_SETTINGS_PATH)
	if err != OK:
		print("[ERROR] Cannot load user settings")
	
func save_settings():
	var err = _user_settings.save(USER_SETTINGS_PATH)
	if err != OK:
		print("[ERROR] Cannot save user settings")
		
func get_keybindings(action):
	return _user_settings.get_value(KEY_BINDING_SECTION, action)
	
func replace_keybinding(action, input, scancode):
	var previous = InputMap.get_action_list(action)
	var event = InputEvent.new()
	event.type = InputEvent.KEY
	event.scancode = scancode
	previous[input] = event
	_user_settings.set_value(KEY_BINDING_SECTION, action, previous)
	save_settings()
	_load_key_bindings()
	
func _create_default_key_bindings():
	_user_settings.set_value(KEY_BINDING_SECTION, "move_up", InputMap.get_action_list("move_up"))
	_user_settings.set_value(KEY_BINDING_SECTION, "move_down", InputMap.get_action_list("move_down"))
	_user_settings.set_value(KEY_BINDING_SECTION, "move_left", InputMap.get_action_list("move_left"))
	_user_settings.set_value(KEY_BINDING_SECTION, "move_right", InputMap.get_action_list("move_right"))
	save_settings()
		
func _load_key_bindings():
	var bindings = _user_settings.get_section_keys(KEY_BINDING_SECTION)
	for binding in bindings:
		InputMap.erase_action(binding)
		InputMap.add_action(binding)
		var inputs = _user_settings.get_value(KEY_BINDING_SECTION, binding)
		for input in inputs:
			InputMap.action_add_event(binding, input)
			
func convert_key_to_string(scancode):
	
	var keys = {
		KEY_A: "A",
		KEY_B: "B",
		KEY_C: "C",
		KEY_D: "D",
		KEY_E: "E",
		KEY_F: "F",
		KEY_G: "G",
		KEY_H: "H",
		KEY_I: "I",
		KEY_J: "J",
		KEY_K: "K",
		KEY_L: "L",
		KEY_M: "M",
		KEY_N: "N",
		KEY_O: "O",
		KEY_P: "P",
		KEY_Q: "Q",
		KEY_R: "R",
		KEY_S: "S",
		KEY_T: "T",
		KEY_U: "U",
		KEY_V: "V",
		KEY_W: "W",
		KEY_X: "X",
		KEY_Y: "Y",
		KEY_Z: "Z",
		KEY_0: "0",
		KEY_1: "1",
		KEY_2: "2",
		KEY_3: "3",
		KEY_4: "4",
		KEY_5: "5",
		KEY_6: "6",
		KEY_7: "7",
		KEY_8: "8",
		KEY_9: "9",
		KEY_LEFT     : "Left",
		KEY_RIGHT    : "Right",
		KEY_UP       : "Up",
		KEY_DOWN     : "Down",
		KEY_SPACE    : "Space",
		KEY_TAB      : "Tab",
		KEY_BACKTAB  : "Backtab",
		KEY_BACKSPACE: "Backspace",
#		KEY_RETURN   : "Return",
		KEY_ENTER    : "Enter",
		KEY_INSERT   : "Insert",
		KEY_DELETE   : "Delete",
		KEY_SHIFT    : "Shift",
		KEY_CONTROL  : "Ctrl",
		KEY_META     : "Meta",
		KEY_ALT      : "Alt"
	}
	if keys.has(scancode):
		return keys[scancode]
	else:
		return ""
