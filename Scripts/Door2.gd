extends Area2D



func _on_Ring_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to(load("res://Label.tscn"))
