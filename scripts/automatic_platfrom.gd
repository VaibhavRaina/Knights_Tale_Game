extends Node2D
@onready var ray_right = $RayRight
@onready var ray_left = $RayLeft
var direction=1
var SPEED=250
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_right.is_colliding():
		direction=-1
	elif ray_left.is_colliding():
		direction=1
	position.x += (SPEED * delta * direction)
