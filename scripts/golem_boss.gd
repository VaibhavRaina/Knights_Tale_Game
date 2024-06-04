extends CharacterBody2D
@onready var player=get_parent().find_child("Player")
@onready var sprite=$Sprite2D
@onready var health_bar = $HealthBar
@onready var death_timer = $DeathTimer
@onready var hurt_box = $HurtBox

var current_damage_type = "heavyDamage"
var direction:Vector2
var health=80
func _ready():
	health_bar.init_health(health)
	set_physics_process(false)

func _process(delta):
	if Input.is_action_just_pressed("attack1"):
		current_damage_type = "lightDamage"
	elif Input.is_action_just_pressed("attack2"):
		current_damage_type = "heavyDamage"
	direction=Vector2(player.position.x, player.position.y - 20)-position
	
	if direction.x<0:
		sprite.flip_h=true
	else:
		sprite.flip_h=false
		
		
func _physics_process(delta):
	velocity=direction.normalized()*40
	move_and_collide(direction*delta)
	
func take_damage(damage):
	health -= damage[current_damage_type]
	health_bar._set_health(health)
	
	if health<=0:
		hurt_box.collision_mask = 0
		health_bar.visible=false
		find_child("FiniteStateMachine").change_state("Death")
		death_timer.start()
		
func apply_pushback(impulse):
	pass


func _on_death_timer_timeout():
	queue_free()
