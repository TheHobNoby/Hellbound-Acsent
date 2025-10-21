extends CharacterBody2D

const JUMP_VELOCITY = -600.0

var walk_speed = 500
var jump_count = 0
var Max_jump = 5
var is_ready: bool = true
var weapon = true
var weapon_cooldown = true 
var Damge_ball = preload("res://Player_Folder/Damge ball.tscn")




func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if is_on_floor():
		jump_count = 0

	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_count < Max_jump:
		velocity.y = JUMP_VELOCITY + (jump_count*100)
		jump_count += 1 

	var playdirtion = get_global_mouse_position()
	$Marker2D.look_at(playdirtion)
	
	if Input.is_action_just_pressed("shot") and weapon and weapon_cooldown:
		weapon_cooldown = false
		if Damge_ball is PackedScene:
			var weapon_ints = Damge_ball.instantiate()
			weapon_ints.rotation = $Marker2D.rotation
			weapon_ints.global_position = $Marker2D.global_position
			add_child(weapon_ints)
			
			await get_tree().create_timer(0.6).timeout
			weapon_cooldown = true
	
	# Movement
	
		
	# Sprint
	if Input.is_action_just_pressed("sprint") and is_on_floor():
		walk_speed += 500
	if Input.is_action_just_released("sprint") and is_on_floor():
		walk_speed -= 500

	# Normal Movement
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * walk_speed
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed)

	#Dash Count
	

	# Dash
	if Input.is_action_just_pressed("dash") and not is_on_floor() and is_ready:
		is_ready = false
		$CoolDown.start()
		walk_speed *= 7.5
		velocity.x = direction * walk_speed
		await get_tree().create_timer(0.1).timeout
		walk_speed = 500
		
	move_and_slide()

func _on_cool_down_timeout() -> void:
	is_ready = true
