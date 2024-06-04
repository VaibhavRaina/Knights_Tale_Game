extends Node

var points=0
@onready var score = $Score
func increament():
	points+=1
	score.text="Your Total Score is"+ " "+str(points)
