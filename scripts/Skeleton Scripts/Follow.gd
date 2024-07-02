extends State


func enter():
	super.enter()
	owner.set_physics_process(true)
	animation_player.play("walking")

func exit():
	super.exit()
	owner.set_physics_process(false)

func transition():
	var distance = owner.direction.length()
 
	if distance <25:
		get_parent().change_state("Attack")	
	#elif distance>80:
		#var chance=randi()%2
		#match chance:
			#0:
				#get_parent().change_state("Pause")
			#1:
				#get_parent().change_state("Pause")


	
