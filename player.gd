extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 980.0

@onready var animated_sprite = $AnimatedSprite2D
@onready var shotgun = $Shotgun

func _physics_process(delta: float) -> void:
	
	# Shotgun stuff
	var mouse_pos = get_global_mouse_position()
	shotgun.look_at(mouse_pos)
	
	# Add gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.play("Walking")
		animated_sprite.flip_h = direction < 0
		shotgun.flip_h = direction < 0
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("Idle")

	# Move the character
	move_and_slide()
