class_name HitBox
extends Area2D
@export var damage={
	"lightDamage":3,
	"heavyDamage":5
}


func _init()->void:
	collision_layer=3	
	collision_mask=0
