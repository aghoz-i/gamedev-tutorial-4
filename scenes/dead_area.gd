extends Area2D

@onready var timer = $Timer
@export var camera: Camera2D 

func _ready():
	$LoseScreen.hide()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if camera:
			camera.reparent(get_tree().current_scene)
			camera.position = camera.global_position
		$LoseScreen.show()
		$LoseScreen/AnimationPlayer.play("Fade In")
		timer.start()
	


func _on_timer_timeout() -> void:
	$LoseScreen/AnimationPlayer.play("Fade Out")
	await $LoseScreen/AnimationPlayer.animation_finished
	$LoseScreen.hide()
	get_tree().reload_current_scene()
