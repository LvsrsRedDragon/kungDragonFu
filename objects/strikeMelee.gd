extends KinematicBody2D


# Declare member variables here. Examples:
var move = Vector2.AXIS_X
var player_direction = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("lifeSpan").start()
	move = 500

func _physics_process(delta):
	move = 200 * player_direction
	move_and_slide(Vector2(move,0))

func _on_lifeSpan_timeout():
	queue_free()
