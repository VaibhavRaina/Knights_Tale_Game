class_name EnemyHitBox
extends Area2D



@export var damage={
	"enemy_damage":{
		"touch_damage":10
	},
	 "golem_damage":{
		"meele_damage":15,
		"laser_damage":20,
		"missile_damgae":10
	}
}


func _init()->void:
	collision_layer=3
	collision_mask=0
