extends Node

@onready var golem_boss = $"../GolemBoss"
@onready var player = $"../Player"
var golem_animation_player

func _ready():
	if is_instance_valid(golem_boss):
		golem_animation_player = golem_boss.get_node("AnimationPlayer")
	damage_parsed()

func _process(_delta):
	if is_instance_valid(golem_animation_player):
		damage_parsed()

func damage_parsed():
	var damage_type_1 = ""
	var damage_type_2 = ""
	if is_instance_valid(golem_boss) and is_instance_valid(golem_animation_player):
		if golem_animation_player.is_playing():
			match golem_animation_player.current_animation:
				"meele_attack":
					damage_type_1 = "golem_damage"
					damage_type_2 = "meele_damage"
				"laser":
					damage_type_1 = "golem_damage"
					damage_type_2 = "laser_damage"
				"ranged_attack":
					damage_type_1 = "golem_damage"
					damage_type_2 = "missile_damage"
				_:
					damage_type_1 = "enemy_damage"
					damage_type_2 = "touch_damage"
		else:
			damage_type_1 = "enemy_damage"
			damage_type_2 = "touch_damage"
	else:
		damage_type_1 = "enemy_damage"
		damage_type_2 = "touch_damage"

	if is_instance_valid(player):
		player.set_attack(damage_type_1, damage_type_2)
