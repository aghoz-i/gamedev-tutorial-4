extends CharacterBody2D

@export var speed: int = 400
@export var gravity: int = 1200
@export var jump_speed: int = -500


func get_input():
	velocity.x = 0
	var gfn_x = get_floor_normal().x
	var gfn_y = get_floor_normal().y
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed
	if Input.is_action_pressed("right"):
		velocity.x += speed
		if is_on_floor() and not Input.is_action_just_pressed("jump") and gfn_x*gfn_y < 0:
			velocity.y += speed
	if Input.is_action_pressed("left"):
		velocity.x -= speed
		if is_on_floor() and not Input.is_action_just_pressed("jump") and gfn_x*gfn_y > 0:
			velocity.y += speed



func _physics_process(delta):
	if not is_on_floor():
		velocity.y += delta * gravity
	get_input()
	move_and_slide()


func _process(_delta):
	if not is_on_floor():
		$Animator.play("Jump")
	elif velocity.x != 0:
		$Animator.play("Walk")
	else:
		$Animator.play("Idle")

	if velocity.x != 0:
		if velocity.x > 0:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true
