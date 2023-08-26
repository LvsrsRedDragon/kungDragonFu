extends Node2D


# Declare member variables here. Examples:
var move = Vector2.AXIS_X


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("lifeSpan").start
	move = 500


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_lifeSpan_timeout():
	queue_free()
