extends Area2D

@export var next_level = "res://Level 2.tscn"

func _on_body_entered(body):
	get_tree().change_scene_to_file(next_level)
