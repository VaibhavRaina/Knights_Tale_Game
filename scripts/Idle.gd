extends State
@onready var collision = $"../../PlayerDetection/CollisionShape2D"
@onready var health_bar = $"../../HealthBar"


var player_entered:bool=false:
	set(value):
		player_entered=value
		collision.set_deferred("disabled",value)
		health_bar.set_deferred("visible",value)
		
func transition():
	if player_entered:
		get_parent().change_state("Follow")


func _on_player_detection_body_entered(body):
	player_entered=true
