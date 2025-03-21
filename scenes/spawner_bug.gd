extends StaticBody2D

@onready var timer = $BugArea/Timer

func _ready():
	$BugWalkingAnimation.play("Walk")
	$BugMovement.play("Move")
	$LoseScreen.hide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$BugArea.set_deferred("monitoring", false)
		$LoseScreen.show()
		$LoseScreen/AnimationPlayer.play("Fade In")
		Global.lives -= 1
		if (Global.lives == 0):
			get_tree().call_deferred("change_scene_to_file", ("res://scenes/GameOver.tscn"))
		timer.start()

func _on_timer_timeout() -> void:
	$LoseScreen/AnimationPlayer.play("Fade Out")
	await $LoseScreen/AnimationPlayer.animation_finished
	$LoseScreen.hide()
	get_tree().reload_current_scene()
