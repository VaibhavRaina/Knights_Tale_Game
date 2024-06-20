extends State
@onready var skeleton = $"../.."


func enter():
	super.enter()
	animation_player.play("death")
	await animation_player.animation_finished
	skeleton.queue_free()
