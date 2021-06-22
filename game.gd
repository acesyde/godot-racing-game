#############################################################
##################### Root Game Scene #######################
#############################################################

extends Node

#--------------
# Constants
#--------------

#--------------
# Variables
#--------------
var current_screen: Node2D
var fps: Label

var screens = {
		"main_menu": preload("res://src/screens/main_menu/screen_main_menu.tscn"),
#		"game": preload("res://screens/game/screen_game.tscn"),
		"controls": preload("res://src/screens/controls/screen_controls.tscn"),
	}

func _ready():
	set_process_input(true)
	set_process(true)
	current_screen = find_node("screen")
	fps = find_node("fps")
	_load_screen("main_menu")
	
func _input(event):
	if event.is_action("game_quit"):
		_load_screen("main_menu")
	elif event.is_action("display_debug") && event.is_pressed():
		fps.visible = !fps.visible
		
func _process(delta):
	fps.set_text("FPS: %d" % Performance.get_monitor(Performance.TIME_FPS))
		
func _load_screen(name):
	if name in screens:
		var old_screen = null
		if current_screen.get_child_count() > 0:
			old_screen = current_screen.get_child(0)
		if old_screen != null:
			current_screen.remove_child(old_screen)

		var new_screen = screens[name].instance()
		new_screen.connect("next_screen", self, "_load_screen")
		current_screen.add_child(new_screen)
	else:
		print("[ERROR] Cannot load screen: ", name)
