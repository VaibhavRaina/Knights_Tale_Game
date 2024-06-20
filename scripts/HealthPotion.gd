extends Area2D
@onready var health_potion = $"."
@onready var player = $"../Player"


func _on_body_entered(body):
	player.health+=30
	health_potion.queue_free()
