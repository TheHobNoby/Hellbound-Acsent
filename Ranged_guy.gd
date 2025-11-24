extends CharacterBody2D

var weapon = true

func _ready():
	print("Shot,shot")
	if weapon:
		weapon = false
		print("fire")
		
		
		await get_tree().create_timer(0.6).timeout
		weapon = true
