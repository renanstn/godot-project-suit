extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 12
const SPEED = 100
const JUMP = 500
var motion = Vector2()
onready var Player = get_node("/root/Environment/Player")

func _physics_process(delta):
	
	# Gravity
	motion.y += GRAVITY
	
	if Player.position.x > position.x:
		$Sprite.set_flip_h(false)
		motion.x = SPEED
	else:
		$Sprite.set_flip_h(true)
		motion.x = -SPEED
	
	motion = move_and_slide(motion, UP)