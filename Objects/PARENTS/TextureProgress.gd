extends TextureProgress

var in_second_stage = 0
var is_growing = false

func _ready():
	pass

func _process(delta):
	if is_growing:
		value += 0.5
		if value == max_value:
			if !in_second_stage:
				value = 0
				in_second_stage = true
				modulate.r = 0
			else:
				print("second stage ended")
	else:
		value -=1
		if value <= 0:
			if in_second_stage:
				value = max_value
				in_second_stage = false
				modulate.r = 1
