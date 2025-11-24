class_name hurtbox
extends Area2D

signal received_damge(damge: int)

@export var health: Health

func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is Hitboxy:
		var hitboxy := area as Hitboxy
		health.health -= hitboxy.damge
		received_damge.emit(hitboxy.damge)
		print("HIT")
