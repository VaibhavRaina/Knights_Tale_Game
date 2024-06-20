extends State
@onready var golem_boss = $"../.."

func enter():
	super.enter()
	animation_player.play("death")
	await animation_player.animation_finished
	golem_boss.queue_free()
	get_tree().reload_current_scene()
 
