extends CharacterBody2D
@onready var player=get_parent().find_child("Player")
@onready var sprite=$Sprite2D
@onready var health_bar = $HealthBar
@onready var hurt_box = $HurtBox
@onready var animation_player = $AnimationPlayer
@onready var buff_timer = $BuffTimer

var current_damage_type = "heavyDamage"
var direction:Vector2
var health_buff=false
@export var health=100
func _ready():
	health_bar.init_health(health)
	set_physics_process(false)

func _process(_delta):
	if Input.is_action_just_pressed("attack1"):
		current_damage_type = "lightDamage"
	elif Input.is_action_just_pressed("attack2"):
		current_damage_type = "heavyDamage"
	direction=Vector2(player.position.x, player.position.y)-position
	if direction.x<0:
		sprite.flip_h=true
	else:
		sprite.flip_h=false
	if health_buff==false:
		if health <= 30:
			find_child("FiniteStateMachine").change_state("ArmorBuff")
			health+=30
			health_bar._set_health(health)
			health_buff=true
		
func _physics_process(delta):
	velocity=direction.normalized()*500
	move_and_collide(direction*delta)
	
func take_damage(damage):
	health -= damage[current_damage_type]
	health_bar._set_health(health)
	
	if health<=0:
		hurt_box.collision_mask = 0
		health_bar.visible=false
		find_child("FiniteStateMachine").change_state("Death")
	

		
		
		
func apply_pushback(_impulse):
	pass


func _on_buff_timer_timeout():
	health+=20
	animation_player.speed_scale=1
