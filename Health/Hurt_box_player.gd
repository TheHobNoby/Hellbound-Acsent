class_name Hurtboxplayer
extends Area2D

signal received_damge(damge: int)

@export var health: Health

func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	var bob := area as HitboxPlayers
	if bob != null:
		health.health -= bob.damge
		received_damge.emit(bob.damge)
		print("HIT on player")
	else:
		print("DEBUG: 'area' entered the hurtbox, but it was not a valid Hitbox type.")
