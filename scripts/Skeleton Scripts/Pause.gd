
extends State

@onready var collision = $"../../PlayerDetection/CollisionShape2D"

func _ready():
	player_entered=false


var player_entered:bool=false:
	set(value):
		player_entered=value
		collision.set_deferred("disabled",value)

		
func transition():
	if player_entered==false:
		get_parent().change_state("Follow")
