extends RigidBody2D

func _ready():
	$AnimationPlayer.play("Freeze")

func _on_falling_trigger_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$AnimationPlayer.play("Shake")
		$FallingTriggerArea/Timer.start()

func _on_timer_timeout() -> void:
	freeze = false
