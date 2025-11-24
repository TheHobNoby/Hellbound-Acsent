class_name hitbox
extends Area2D

@export var damge: int = 1 : set = set_damge, get = get_damge


func set_damge(value: int):
		damge = value


func get_damge() -> int:
	return damge
