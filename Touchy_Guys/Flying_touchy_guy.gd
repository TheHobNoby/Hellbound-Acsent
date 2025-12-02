extends CharacterBody2D

func _ready():
	$AnimatedSprite2D.play("default")

func _on_health_health_depleted() -> void:
	velocity = Vector2.ZERO
	$AnimatedSprite2D.play("Death")
	await $AnimatedSprite2D.animation_finished
	queue_free()

func _on_health_health_changed() -> void:
	$AnimatedSprite2D.play("Damage")
	await $AnimatedSprite2D.animation_finished
	$AnimatedSprite2D.play("default")
