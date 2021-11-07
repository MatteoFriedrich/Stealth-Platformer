extends Area2D

func _ready():
	pass

func _process(delta):
	if $"/root/main".has_ring:
		queue_free()
