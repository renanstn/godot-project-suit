extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 12
const SPEED = 200
const JUMP = 500
var motion = Vector2()
var localMousePosition
var globalMousePosition
var lookRight
var playerPosition

func _physics_process(delta):
	
	# Get local and global mouse positions
	localMousePosition  = get_local_mouse_position()
	globalMousePosition = get_global_mouse_position()
	
	# Fazer o braço apontar para o mouse
	$Arm.rotation = localMousePosition.angle()
	
	# Checar se o player esta olhando pra esquerda ou direita
	if position.x < globalMousePosition.x:
		lookRight = 1
	else:
		lookRight = 0
		
#	if lookRight:
#		set_scale(Vector2(1, 1))
#	else:
#		set_scale(Vector2(-1, 1))
	
	# Gravity
	motion.y += GRAVITY
	
	# Movement
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		# Inverter o eixo caso seja um sprite simples ou pré animado
		$Sprite.flip_h = false
		# Utilizar este outro método de inversão caso seja um sprite com várias partes montadas em uma animação estilo cutout
		# $Sprite.set_scale(Vector2(1,1))
		# $Sprite.play("run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		# Inverter o eixo caso seja um sprite simples ou pré animado
		$Sprite.flip_h = true
		# Utilizar este outro método de inversão caso seja um sprite com várias partes montadas em uma animação estilo cutout
		# $Sprite.set_scale(Vector2(-1,1))
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
	var shoot = load("res://scenes/Shoot.tscn").instance()
	shoot.position = $Arm/GunPoint.get_global_position()
	# shoot.add_impulse(Vector2(0, 0), Vector2(50, 0))
	get_parent().add_child(shoot)
	