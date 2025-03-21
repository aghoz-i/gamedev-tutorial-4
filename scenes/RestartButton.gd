extends LinkButton



func _on_pressed() -> void:
	Global.lives = 3
	get_tree().change_scene_to_file("res://scenes/Level1.tscn")
