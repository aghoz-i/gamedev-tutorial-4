extends Area2D

@onready var timer = $Timer
@export var camera: Camera2D 
@export var sceneName: String

func _ready():
	$LoseScreen.hide()

func _on_body_entered(body: Node2D) -> void:
	var current_scene = get_tree().current_scene.name;
	if body.name == "Player":
		if current_scene == sceneName:
			Global.lives -=1
		if (Global.lives == 0):
			get_tree().call_deferred("change_scene_to_file", ("res://scenes/GameOver.tscn"))
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
