extends Area2D

@onready var timer = $Timer
@onready var player = $".."

@onready var animated_sprite_2d = $"../AnimatedSprite2D"

func _on_body_entered(body):
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()

func _on_timer_timeout():
	player.get_node("CollisionShape2D").queue_free()
	Engine.time_scale = 1
	get_tree().reload_current_scene()


func _on_player_player_death():
	print("Player died")
	Engine.time_scale = 0.5
	animated_sprite_2d.play("death")
	timer.start()
	print("CollisionShape2D disabled")
