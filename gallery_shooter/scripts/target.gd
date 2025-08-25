extends Area2D

signal time_added

var hovering: bool = false
var difficulty: int = 1

func _on_mouse_entered():
	hovering = true
	modulate = Color(1.2, 1.2, 1.2)  # Brighten when hovered

func _on_mouse_exited():
	hovering = false
	modulate = Color(1.0, 1.0, 1.0)  # Return to normal

func _unhandled_input(event):
	if event.is_action_pressed('mouse_left') && hovering:
		time_added.emit(difficulty)
		queue_free()

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	get_parent().queue_free()
