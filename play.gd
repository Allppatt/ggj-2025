extends Control



func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")


func _on_option_pressed() -> void:
	get_tree().change_scene_to_file("res://options_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
