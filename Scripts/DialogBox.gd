extends RichTextLabel

export var dialog = ["After the one ring was destroyed everyone thought that the fight was over. But Sauron hasn’t died.", 
"He returned to craft an even stronger new ring of power which he used to conquer the peoples of Middle Earth.", 
"The elves decided to send their best Assassin on a mission so she could kill the Dark Lord once and for all.",
""]
var page = 0
var new_text = null

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("jump") and page+1 < dialog.size():
		page += 1
	
	new_text = dialog[page]
	if new_text != text:
		text = new_text
		update_text(text)
	if page == dialog.size()-1:
		queue_free()

func update_text(new_text):
	visible_characters = 0
	for i in range(new_text.length()):
		visible_characters += 1
		yield(get_tree().create_timer(0.05, true), "timeout")
