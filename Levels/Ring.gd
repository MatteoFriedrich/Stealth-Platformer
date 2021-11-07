extends Area2D



func _on_Ring_body_entered(body):
	if body.name == "Player":
		get_node("/root/main").has_ring = true
		get_tree().change_scene_to(load("res://Levels/Level2.tscn"))
		
