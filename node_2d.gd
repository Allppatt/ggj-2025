extends Node2D

@export var intro_duration : float = 5.0  # Durasi intro dalam detik
@export var fade_duration : float = 3.0   # Durasi fade-in dan fade-out

var animation_player : AnimationPlayer

func _ready():
	animation_player = $AnimationPlayer
	
	# Mulai animasi fade-in saat intro dimulai
	animation_player.play("Fade in")
	
	# Tunggu intro selesai sebelum fade-out
	await get_tree().create_timer(intro_duration).timeout
	
	# Mulai animasi fade-out setelah intro selesai
	animation_player.play("Fade out")
	
	# Tunggu beberapa detik sampai animasi fade-out selesai
	await get_tree().create_timer(fade_duration).timeout
	
	# Pindah ke scene menu setelah fade-out selesai
	get_tree().change_scene_to_file("res://menu.tscn")
