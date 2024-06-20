extends CharacterBody2D

@onready var health_bar = $HealthBar

var SPEED = 100.0
const JUMP_VELOCITY = -300.0
const RUN_SPEED = 150
const ROLL_SPEED = 200
@onready var jump_timer = $JumpTimer
@onready var roll_timer = $RollTimer
@onready var attack_animation = $AttackAnimation
@onready var hit_box = $HitBox
@onready var collision_shape_2d = $HitBox/CollisionShape2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player_damage = $PlayerDamage
@onready var death_timer = $DeathTimer
@onready var hit_timer = $HitTimer
@onready var player = $"."
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
signal player_death
var isDead = false
var isHit = false
var health = 70
var damage_type_1 = ""
var damage_type_2 = ""

var current_state = "idle"

func attack(x, y, r1, r2, animation):
	var direction = Input.get_axis("move_left", "move_right")
	if direction > 0:
		attack_animation.position = Vector2(x, -y)
		attack_animation.rotation_degrees = r1
		hit_box.position = Vector2(0, 0)
	elif direction < 0:
		attack_animation.position = Vector2(-x, -y)
		attack_animation.rotation_degrees = -r1
		hit_box.position = Vector2(-26, 0)
	if not animated_sprite_2d.flip_h:
		if Input.is_action_just_pressed(str(animation)):
			attack_animation.flip_h = false
			attack_animation.visible = true
			attack_animation.play(str(animation))
			collision_shape_2d.disabled = false
	elif animated_sprite_2d.flip_h:
		if Input.is_action_just_pressed(str(animation)):
			attack_animation.flip_h = true
			attack_animation.visible = true
			collision_shape_2d.disabled = false
			attack_animation.play(str(animation))

func _ready():
	health_bar.init_health(health)



func _physics_process(delta):
	
	if isDead or isHit:
		return
	if health>0:
		health_bar._set_health(health)
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("move_left", "move_right")

	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true

	# State management and prioritization
	if is_on_floor():
		if Input.is_action_just_pressed("roll"):
			current_state = "dodge"
			SPEED = ROLL_SPEED
			animated_sprite_2d.play("dodge")
			roll_timer.start()
			print("Playing dodge")
		elif direction != 0:
			if current_state != "dodge":
				current_state = "run"
				SPEED = RUN_SPEED
				animated_sprite_2d.play("run")
				
		else:
			if current_state != "dodge":
				current_state = "idle"
				SPEED = 100
				animated_sprite_2d.play("idle")
				
	else:
		if current_state != "dodge":
			current_state = "jump"
			animated_sprite_2d.play("jump")
			jump_timer.start()
			

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	attack(7, 10, 55.6, 110, "attack1")
	attack(7, 10, 55.6, 115, "attack2")

# Timer callback functions
func _on_roll_timer_timeout():
	SPEED = 100
	current_state = "run"  # or "idle" depending on your desired behavior
	animated_sprite_2d.play("run")
	print("Roll ended, switching to run")

# Damage System
func set_attack(value1, value2):
	damage_type_1 = value1
	damage_type_2 = value2

func take_damage(damage):
	if damage_type_1 in damage and damage_type_2 in damage[damage_type_1]:
		health -= damage[damage_type_1][damage_type_2]
	else:
		print("Invalid damage type:", damage_type_1, damage_type_2)
		return
	if health > 0:
		isHit = true
		health_bar._set_health(health)
		hit_timer.start()
		animated_sprite_2d.play("hit")
		
	else:
		isDead=true
		player_damage.collision_mask = 0
		health_bar.queue_free()
		emit_signal("player_death")

func _on_attack_animation_animation_finished():
	attack_animation.visible = false
	collision_shape_2d.disabled = true

func _on_death_timer_timeout():
	get_tree().reload_current_scene()


func _on_hit_timer_timeout():
	current_state = "idle"
	animated_sprite_2d.play("idle")
	isHit = false

func _on_jump_timer_timeout():
	if current_state != "dodge":
		animated_sprite_2d.play("run")


