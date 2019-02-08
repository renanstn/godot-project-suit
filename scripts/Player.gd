extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 12
const SPEED = 200
const JUMP = 500
const BULLET_SPEED = 5
var motion = Vector2()
var lookRight
var playerPosition
var bullet = preload("res://scenes/Shoot.tscn")

func _physics_process(delta):
	
	set_arm_rotation()
	
	# Checar se o player esta olhando pra esquerda ou direita
	if position.x < get_global_mouse_position().x:
		lookRight = 1
		flip_player(lookRight)
	else:
		lookRight = 0
		flip_player(lookRight)
	
	# Gravity
	motion.y += GRAVITY
	
	# Movement
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		# $Sprite.play("run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		# $Sprite.play("run")
	else:
		motion.x = 0
		# $Sprite.play("idle")
		
	if Input.is_action_just_pressed("atirar"):
		shoot()
	
	# Jump
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		motion.y = -JUMP
	else:
		# $Sprite.play("jump")
		pass
	
	motion = move_and_slide(motion, UP)
	
func shoot():
	var clone_bullet = bullet.instance()
	# var bullet_angle = get_angle_to(get_global_mouse_position()) + $Arm/SpawnBullets.get_rotation()
	# clone_bullet.set_rotation(bullet_angle)
	clone_bullet.rotation = $Arm.rotation
	clone_bullet.position = $Arm/SpawnBullets.get_global_position()
	get_parent().add_child(clone_bullet)
	var direction = get_global_mouse_position() - get_global_position()
	clone_bullet.apply_impulse(Vector2(), direction * BULLET_SPEED)
	
func set_arm_rotation():
	# Fazer o braço apontar para o mouse
	$Arm.rotation = get_local_mouse_position().angle()
	
func flip_player(to_right):
	# Flip nos sprites quando o personagem vira
	if to_right:
		$Sprite.set_scale(Vector2(1, 1))
		$Arm.set_scale(Vector2(1.5, 0.5))
	else:
		$Sprite.set_scale(Vector2(-1, 1))
		$Arm.set_scale(Vector2(1.5, -0.5))