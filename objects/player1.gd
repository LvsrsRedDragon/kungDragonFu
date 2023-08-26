extends KinematicBody2D


var state = ["normal", "attacking", "dead", "crouched", "spAttacking"]
var side = "right"
export var gravity = 100
export var gMax = 500
export var moveSpeed = 400
var motion = Vector2.ZERO
export var jumpPower = -300
var playerHP = 100.0
var atkType = "punch"
var spType = "dash"
var chargeAtk = "false"
var doubleJump = "false"
var playerArmor = 1
var atkBuffer = 0
var atkDirection = 1
var strike = preload("res://objects/strikeMelee.tscn")
var strikeSpeed = 500
# Called when the node enters the scene tree for the first time.


#func fireAttack():
#	strike.move = strike.position.global_translation
#	strike.rotation = 
#
func _ready():
	state = "normal"
		
func change_direction():
	if side == "left":
		get_node( "Sprite" ).set_flip_h( false )
		atkDirection = -1
	elif side == "right":
		get_node( "Sprite" ).set_flip_h( true )
		atkDirection = 1
func basic_platforming():
	if Input.is_action_pressed("moveLeft"):
			motion.x = -moveSpeed
	elif Input.is_action_pressed("moveRight"):
			motion.x = moveSpeed
	else:
		motion.x = 0
	if is_on_floor():
		if Input.is_action_pressed("jump"):
			motion.y = jumpPower
		else:
			pass
func basic_states():
	if state == "normal":
		basic_platforming()
		get_node("Player/AnimatedSprite2").play("Idle")
		if Input.is_action_pressed("Attack"):
			state = "attacking"
			get_node("atkTimer").start()
		elif Input.is_action_pressed("crouch") and is_on_floor():
			state = "crouched"
		elif Input.is_action_just_pressed("spAttack"):
			state = "spAttacking"
	if state == "crouched":
		get_node("Player/AnimatedSprite2").play("Crouch")
		motion.x = 0
		motion.y = 0
		if Input.is_action_just_released("crouch"):
			state = "normal"
	if state == "attacking":
		motion.x = 0
		motion.y = 0
		get_node("Player/AnimatedSprite2").frame = atkBuffer
		get_node("Player/AnimatedSprite2").animation = "Attack"
		if atkBuffer <= 2:
			if Input.is_action_just_pressed("Attack"):
				get_node("atkTimer").start()
				atkBuffer += 1
func _physics_process(delta):
	move_and_slide(motion, Vector2.UP)
	basic_states()
	if Input.is_action_pressed("moveLeft"):
		side = "left"
	elif Input.is_action_pressed("moveRight"):
		side = "right"
	if gravity <= gMax:
		motion.y += gravity
	change_direction()


func _on_atkTimer_timeout():
	state = "normal"
	atkBuffer = -1
