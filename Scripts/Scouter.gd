extends "res://Scripts/PARENTS/Creature.gd"

func _ready():
	pass

func _process(delta):
	state = states.IDLE
	$PlayerDetecter.cast_to = (player.position-position)*2

func _on_HitBox_area_entered(area):
	queue_free()


func _on_LookRange_body_entered(body):

	if $PlayerDetecter.get_collider() == player:
		player_in_range = true


func _on_LookRange_body_exited(body):
	player_in_range = false
