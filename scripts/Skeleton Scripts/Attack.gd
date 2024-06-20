extends State
@onready var enemy_hit_box = $"../../EnemyHitBox/EnemyHitBox"
@onready var enemy_hit_box_2 = $"../../EnemyHitBox/EnemyHitBox2"
@onready var attack_timer = $"../../AttackTimer"
@onready var animation_player_2 = $"../../AnimationPlayer2"



func _process(delta):
	if $"../../AnimationPlayer".animation=="attack":
		animation_player_2.play("attack")
		
func enter():
	super.enter()
	animation_player.play("attack")
	

func transition():
	var distance=owner.direction.length()
	if distance > 30 :
		get_parent().change_state("Follow")




func _on_attack_timer_timeout():
		enemy_hit_box.disabled=true
		enemy_hit_box_2.disabled=true
