extends Control



func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://screen/PlayingScreen/game.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://options_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
