extends AnimatedSprite2D

var Damge_ball = preload("res://Touchy_Guys/arrow.tscn")

# Use @onready to get child nodes correctly, including the new Timer
@onready var marker_2d = $Marker2D
@onready var arrow_timer: Timer = $ArrowTimer # Reference the new Timer node

var death = false


func _on_arrow_timer_timeout():
	if Damge_ball is PackedScene:
		if not death:
			var weapon_ints = Damge_ball.instantiate()
			weapon_ints.rotation = marker_2d.rotation
			weapon_ints.global_position = marker_2d.global_position
			get_tree().root.add_child.call_deferred(weapon_ints) 



func _on_health_health_depleted():
	death = true
	self.play("Death")
	await self.animation_finished
	call_deferred("queue_free")
	




func _on_health_health_changed() -> void:
	self.play("Damage")
	await self.animation_finished
	self.play("default")
	
