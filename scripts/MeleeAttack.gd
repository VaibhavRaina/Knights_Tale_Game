extends State



func enter():
	super.enter()
	animation_player.play("meele_attack")
		

func transition():
	if owner.direction.length() > 30:
		get_parent().change_state("Follow")
	
