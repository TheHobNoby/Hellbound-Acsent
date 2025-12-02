extends CharacterBody2D

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D

const JUMP_VELOCITY = -600.0
var walk_speed = 250
var jump_count = 0
var Max_jump = 5
var is_ready: bool = true
var weapon = true
var weapon_cooldown = true 
var Damge_ball = preload("res://Player_Folder/Damge ball.tscn")
var current_health: int = 3
var hit_count = 0
var can_move: bool = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if is_on_floor():
		jump_count = 0

	if not is_on_floor:
		for i in 50:
			anim.play("Jump_P2")
		

	if can_move:
		# your normal movement input code
		# e.g. velocity.x = ...
		move_and_slide()
	else:
		velocity = Vector2.ZERO
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_count < Max_jump:
		anim.play("Jump_P2")
		velocity.y = JUMP_VELOCITY + (jump_count*100)
		jump_count += 1 
		await anim.animation_finished
		anim.play("default")


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
	if Input.is_action_just_pressed("left") and is_on_floor():
		anim.play("Movement")
	if Input.is_action_just_released("left"):
		anim.play("default")
	if Input.is_action_just_pressed("right") and is_on_floor():
		anim.play("Movement")
	if Input.is_action_just_released("right"):
		anim.play("default")
	# Normal Movement
	var direction := Input.get_axis("left", "right")
	print(walk_speed)
	if direction:
		velocity.x = direction * walk_speed
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed)
		
	if velocity.x < 0:
		anim.flip_h = true
	else:
		anim.flip_h = false
	#Dash Count
	

	# Dash
	if Input.is_action_just_pressed("dash") and not is_on_floor() and is_ready:
		$AnimatedSprite2D.play("Dash_P1")
		await $AnimatedSprite2D.animation_finished
		$AnimatedSprite2D.play("Dash_P2")
		is_ready = false
		$CoolDown.start()
		walk_speed *= 9
		velocity.x = direction * walk_speed
		await get_tree().create_timer(0.1).timeout
		walk_speed = 250
		$AnimatedSprite2D.play("default")
	
	if can_move:
		move_and_slide()
	else:
		velocity = Vector2.ZERO

func _on_cool_down_timeout() -> void:
	is_ready = true



func _on_health_health_depleted() -> void:
	can_move = false             
	velocity = Vector2.ZERO       

	anim.play("Death")
	await anim.animation_finished

	get_tree().reload_current_scene()


func _on_health_health_changed() -> void:
	if hit_count == 0:
		$CanvasLayer/Health_bar_2D.play("default")
		hit_count += 1
		return
	if hit_count == 1:
		$CanvasLayer/Health_bar_2D.play("2")
		hit_count += 1
		return
	if hit_count == 2:
		$CanvasLayer/Health_bar_2D.play("3")
		hit_count += 1
		return
	if hit_count == 3:
		$CanvasLayer/Health_bar_2D.play("4")
		hit_count += 1
		return
