extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player=get_parent().find_child('Player')

var acceleration:Vector2=Vector2.ZERO
var velocity:Vector2=Vector2.ZERO

func _physics_process(delta):
	acceleration=(Vector2(player.position.x, player.position.y-10)-position).normalized()*700
	velocity += acceleration * delta
	rotation = velocity.angle()
 
	velocity = velocity.limit_length(150)
 
	position += velocity * delta


func _on_body_entered(_body):
	queue_free()
