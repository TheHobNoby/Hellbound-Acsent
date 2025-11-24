extends Area2D

var reaspawn_manger

func _ready() -> void:
	reaspawn_manger = get_parent().get_parent().get_node("respawn_manger")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		reaspawn_manger.last_location = $"Respawn Point".global_position
