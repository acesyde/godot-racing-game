extends "res://src/screens/abstract_screen.gd"

func _on_quit_pressed():
	get_tree().quit()

func _on_controls_pressed():
	emit_signal("next_screen", "controls")

func _on_play_pressed():
	emit_signal("next_screen", "game")
