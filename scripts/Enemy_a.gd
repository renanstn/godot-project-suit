extends KinematicBody2D

const V_SPEED = 5
const H_SPEED = 3
const UP_LIMIT = 100
const MAX_SPEED = 100
const BORDER_LIMIT = 100
var screensize
var direction
var chave = false
var motion = Vector2()
onready var Player = get_node("/root/Environment/Player")

func _ready():
	
	randomize()
	var direction = choose_randomly([-1, 1])
	screensize = get_viewport_rect().size

func _process(delta):
		pass

func _physics_process(delta):
	
	directionsController()
	
	# Up/Down controller
	if position.y > UP_LIMIT:
		motion.y -= V_SPEED/2
	else:
		motion.y += V_SPEED/2
	
	# Left/Rigth controller
	if direction == 1: # Rigth
		motion.x -= H_SPEED
		$Sprite.set_flip_h(true)
		$EnemyGun.set_flip_h(true)
	elif direction == -1: # Left
		motion.x += H_SPEED
		$Sprite.set_flip_h(false)
		$EnemyGun.set_flip_h(false)
	
	motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	motion = move_and_slide(motion)
	
func directionsController():
	if position.x > BORDER_LIMIT and chave == false:
		direction = 1
	elif position.x < (screensize.x - BORDER_LIMIT):
		direction = -1
		chave = true
	
	if position.x > (screensize.x - BORDER_LIMIT):
		chave = false
	
func choose_randomly(list_of_entries):
	return list_of_entries[randi() % list_of_entries.size()]