extends CharacterBody2D
@onready var animation_player = $AnimationPlayer
@onready var player=get_parent().find_child("Player")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var SkeletonShape = $CollisionShape2D
@onready var finite_state_machine = $FiniteStateMachine
@onready var health_bar = $HealthBar
@onready var hurt_box = $HurtBox
const GRAVITY = 200.0





var current_damage_type = "heavyDamage"
var direction:Vector2
var health=50
func _ready():
	health_bar.init_health(health)
	set_physics_process(false)


func _process(_delta):
	if Input.is_action_just_pressed("attack1"):
		current_damage_type = "lightDamage"
	elif Input.is_action_just_pressed("attack2"):
		current_damage_type = "heavyDamage"
	direction=Vector2(player.position.x,0)-Vector2(position.x,0)
	#direction=Vector2(player.position.x,player.position.y)-Vector2(position.x,position.y)
	#direction=player.position-position
	if direction.x<0:
		animation_player.flip_h=false
	else:
		animation_player.flip_h=true

func _physics_process(delta):
	
	if not is_on_floor():
		finite_state_machine.change_state("Idle")
		direction=Vector2(0,1)
		
		
	velocity=direction.normalized()*100
	move_and_slide()
	
func take_damage(damage):
	health -= damage[current_damage_type]
	health_bar._set_health(health)
	
	if health<=0:
		hurt_box.collision_mask = 0
		health_bar.visible=false
		find_child("FiniteStateMachine").change_state("Death")
	
		
func apply_pushback(_impulse):
	pass



