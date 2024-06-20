extends Node2D

var SPEED = 101
var direction = 1
var pushback_force = Vector2.ZERO
var pushback_duration = 0.2
var pushback_timer = 0.0
@onready var enemy_hit_box = $EnemyHitBox

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var health_bar = $HealthBar
@onready var timer = $Timer
@onready var collision_shape_2d = $HurtBox/CollisionShape2D
@onready var hurt_box = $HurtBox
@onready var hit_timer = $HitTimer

var health = 12
var current_damage_type = "heavyDamage"

func _ready():
	health_bar.init_health(health)
	animated_sprite_2d.play("default")  # Start with idle animation

func _process(delta):
	# Handle pushback effect
	if pushback_timer > 0:
		position.x += pushback_force.x * delta
		pushback_timer -= delta
		return  # Skip normal movement during pushback
	
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	elif ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false

	position.x += SPEED * delta * direction

	if Input.is_action_just_pressed("attack1"):
		current_damage_type = "lightDamage"
	elif Input.is_action_just_pressed("attack2"):
		current_damage_type = "heavyDamage"

func take_damage(damage):
	health -= damage[current_damage_type]
	health_bar._set_health(health)

	if health <= 0:
		SPEED=0
		hurt_box.collision_mask = 0
		animated_sprite_2d.play("dead")
		timer.start()
	else:
		animated_sprite_2d.play("hit")
		hit_timer.start()
		

func apply_pushback(impulse: Vector2):
	pushback_force = Vector2(impulse.x, 0)
	pushback_timer = pushback_duration

func _on_timer_timeout():

	queue_free()
	hurt_box.collision_mask = 2


func _on_hit_timer_timeout():
	if health>0:
		animated_sprite_2d.play("default")
	else:
		pass
	
