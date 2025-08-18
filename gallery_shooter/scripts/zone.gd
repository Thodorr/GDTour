extends Node2D

func _ready():
	$WorldTimer.start(20)  # Start with 20 seconds

func _process(_delta):
	# Update time display
	$CanvasLayer/Label.text = str(int($WorldTimer.time_left))
