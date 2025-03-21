extends Area2D

@onready var timer = $Timer

func _on_ready():
	$WinScreen.hide()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$WinScreen/RestartText.text = "Loading Level 2...."
		$WinScreen.show()
		$WinScreen/AnimationPlayer.play("Fade In")
		timer.start()


func _on_timer_timeout() -> void:
	$WinScreen/RestartText.text = "Finished..."
	$WinScreen/AnimationPlayer.play("Fade Out")
	await $WinScreen/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/Level2.tscn")
