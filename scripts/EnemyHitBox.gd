class_name EnemyHitBox
extends Area2D

@onready var animation_player_golem = $"../../../AnimationPlayer"

@export var damage={
	"slime_damage":5,
	 "golem_damage":{
		"meele_damage":5,
		"laser_damage":10,
		"missile_damgae":8
	}
}


func _init()->void:
	collision_layer=3
	collision_mask=0
