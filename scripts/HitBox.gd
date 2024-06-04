class_name HitBox
extends Area2D
@export var damage={
	"lightDamage":2,
	"heavyDamage":4
}


func _init()->void:
	collision_layer=3	
	collision_mask=0
