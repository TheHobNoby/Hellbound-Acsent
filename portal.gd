extends Area2D

@export var next_level: String = "res://Level 2.tscn"

func _on_body_entered(body):
	if body is CharacterBody2D:
		get_tree().change_scene_to_file(next_level)
