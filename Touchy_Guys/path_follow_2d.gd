extends PathFollow2D

@export var speed := 500.0

var sprite
var last_x := 0.0

func _ready():
	rotates = false
	sprite = get_node("CharacterBody2D/AnimatedSprite2D")
	last_x = global_position.x

func _process(delta):
	progress += speed * delta

	# Detect if moving left or right using position change
	var moving_left = global_position.x < last_x
	sprite.flip_h = moving_left

	last_x = global_position.x
