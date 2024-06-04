extends CharacterBody2D
@onready var health_bar = $HealthBar


var SPEED = 100.0
const JUMP_VELOCITY = -300.0
const RUN_SPEED=150
const ROLL_SPEED=200
@onready var timer = $Timer
@onready var timer_2 = $Timer2
@onready var attack_animation = $AttackAnimation
@onready var hit_box = $HitBox
@onready var collision_shape_2d = $HitBox/CollisionShape2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player_damage = $PlayerDamage
@onready var death_timer = $DeathTimer
@onready var hit_timer = $HitTimer
@onready var golem_boss=get_parent().find_child("GolemBoss")



var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isDead=false
var isHit=false
var x=0

func attack(x,y,r1,r2,animation):
	var direction = Input.get_axis("move_left", "move_right")
	if direction>0:
		
		attack_animation.position=Vector2(x,-y)
		attack_animation.rotation_degrees=r1
		hit_box.position=Vector2(0,0)
	elif direction<0:
		attack_animation.position=Vector2(-x,-y)
		attack_animation.rotation_degrees=-r1
		hit_box.position=Vector2(-26,0)
	if animated_sprite_2d.flip_h==false:
		if Input.is_action_just_pressed(str(animation)):
			attack_animation.flip_h=false
			attack_animation.visible=true
			attack_animation.play(str(animation))
			collision_shape_2d.disabled=false
	elif animated_sprite_2d.flip_h==true:
		if Input.is_action_just_pressed(str(animation)):
			attack_animation.flip_h=true
			attack_animation.visible=true
			collision_shape_2d.disabled=false
			attack_animation.play(str(animation))

var health=100
func _ready():
	health_bar.init_health(health)
	
	
func _physics_process(delta):
	if isDead==true or isHit==true:
		return
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("move_left", "move_right")
	
	if direction>0:
		animated_sprite_2d.flip_h=false
	elif direction<0:
		animated_sprite_2d.flip_h=true
	
	if is_on_floor():
		if direction==0:
				SPEED=100
				var x=0
				animated_sprite_2d.play("idle")
		elif (direction!=0 and Input.is_action_just_pressed("sprint")):
				SPEED=RUN_SPEED
				var x=2;
				animated_sprite_2d.play("run")
				
		if (Input.is_action_just_pressed("roll") and is_on_floor()):
				SPEED=ROLL_SPEED
				animated_sprite_2d.play("dodge")
				timer_2.start()
		if (Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right")):
			var x=1
			animated_sprite_2d.play("walk")
			
	else:
			animated_sprite_2d.play("jump")
			timer.start()
						
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
	attack(7,10,55.6,110,"attack1")
	attack(7,10,55.6,115,"attack2")
	 
	
	
func take_damage(damage):
	health-=damage
	if health!=0:
		isHit=true
		hit_timer.start()
		animated_sprite_2d.play("hit")
		health_bar._set_health(health)
	else:
		player_damage.collision_mask=0
		isDead=true
		health_bar.queue_free()
		animated_sprite_2d.play("death")
		death_timer.start()
		
	
func _on_timer_timeout():
		animated_sprite_2d.play("run")
		
	
	


func _on_timer_2_timeout():
	SPEED=100
	animated_sprite_2d.play("idle")


func _on_attack_animation_animation_finished():
		attack_animation.visible=false
		collision_shape_2d.disabled=true


func _on_death_timer_timeout():
	player_damage.collision_mask=2
	isDead=false
	queue_free()
	get_tree().reload_current_scene()

	
	
func _on_hit_timer_timeout():
	animated_sprite_2d.play("idle")
	isHit=false
	
