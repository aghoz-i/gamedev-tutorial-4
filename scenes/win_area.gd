extends Area2D

func _on_ready():
	$WinScreen.hide()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$WinScreen.show()
		$WinScreen/AnimationPlayer.play("Fade In")
		set_process(true)

func _process(delta):
	if Input.is_key_pressed(KEY_R):
		restart_game()

func restart_game():
	set_process(false)
	$WinScreen/AnimationPlayer.play("Fade Out")
	await $WinScreen/AnimationPlayer.animation_finished
	$WinScreen.hide()
	get_tree().reload_current_scene()
