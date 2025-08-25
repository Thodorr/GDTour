extends Node2D

var target_scene = preload('res://gallery_shooter/scenes/target.tscn')

var spawn_time = 1.5

func _ready():
	randomize()
	$WorldTimer.start(20)
	$DelayTimer.wait_time = spawn_time
	$DelayTimer.start()

func _process(_delta):
	# Update time display
	var time_left = $WorldTimer.time_left
	$CanvasLayer/Label.text = str(int(time_left))
	
	# Check for game over
	if time_left <= 0:
		game_over()

func game_over():
	$DelayTimer.stop()
	$CanvasLayer/Label.text = "GAME OVER"
	# Remove all remaining targets
	for child in get_children():
		if child is Marker2D:
			child.queue_free()

func create_spawn():
	var new_spawn = Marker2D.new()
	var new_target = target_scene.instantiate()
	add_child(new_spawn)
	new_spawn.add_child(new_target)
	new_target.time_added.connect(_on_time_added)
	
	# Choose random animation
	var animations = ['straight_right', 'straight_left', 'wave_right']
	var chosen_anim = animations[randi() % animations.size()]
	
	# Set random spawn position
	if chosen_anim.contains('left'):
		new_spawn.position = Vector2(1180, randf_range(30, 600))
	else:
		new_spawn.position = Vector2(-30, randf_range(30, 600))
	
	var anim_player = new_target.get_node('AnimationPlayer')
	anim_player.play(chosen_anim)
	anim_player.speed_scale = randf_range(0.2, 0.6)

func _on_time_added(time):
	$WorldTimer.start($WorldTimer.time_left + time)

func _on_delay_timer_timeout():
	create_spawn()
	# Gradually decrease spawn time (increase difficulty)
	spawn_time = max(0.3, spawn_time - 0.05)
	$DelayTimer.wait_time = spawn_time
