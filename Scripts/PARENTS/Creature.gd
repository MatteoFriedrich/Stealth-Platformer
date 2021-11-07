extends KinematicBody2D
#define enums
enum states{
	IDLE,
	MOVE
}
enum facing_direction{
	RIGHT,
	LEFT
}

export(facing_direction) var current_direction = facing_direction.RIGHT
export var move_speed = 60 # how fast does our creature move?
export var player_path : NodePath

onready var right_ray : RayCast2D = $ray_right
onready var left_ray : RayCast2D = $ray_left
onready var ani : AnimatedSprite = $AnimatedSprite
onready var player = get_node(player_path)

var hSpeed = 0 # how fast is our creature currently moving?
var vSpeed = 0 # how fast are we moving up or down?
var on_ledge : bool = false # determine if we're on a ledge
var player_in_range : bool = false

var state = states.MOVE

var motion = Vector2.ZERO
var UP: Vector2 = Vector2(0,-1)


func _ready():
	update_facing_direction()
	pass # Replace with function body.
	
func _physics_process(delta):
	if ((player.position.x > position.x and current_direction == facing_direction.RIGHT) or (player.position.x < position.x and current_direction == facing_direction.LEFT)) and player_in_range:
		get_tree().reload_current_scene()
		$"/root/main".level = get_parent().name
		#$TextureProgress.is_growing = true
	else:
		$TextureProgress.is_growing = false
	match state:
		states.MOVE:
			do_physics(delta)
		states.IDLE:
			pass
	
func check_if_on_ledge():
	if(left_ray.is_colliding() != right_ray.is_colliding()):
		return true
	else:
		return false
	
func do_physics(var delta):
	$PlayerDetecter.cast_to = (player.position-position)*2
	on_ledge = check_if_on_ledge()
	match_speed_to_direction()
	fall()
	motion.y = vSpeed
	motion.x = hSpeed
	motion = move_and_slide(motion,UP)

func fall():
	vSpeed += 60
	if is_on_floor():
		vSpeed = 0

func update_facing_direction():
	if(current_direction == facing_direction.RIGHT):
		ani.flip_h = true
		$Position2D.rotation_degrees = 180
		$AttackShape.position.x = 10
	else:
		ani.flip_h = false
		$Position2D.rotation_degrees = 0
		$AttackShape.position.x = -10
		
func match_speed_to_direction():
	if(current_direction == facing_direction.RIGHT):
		hSpeed = move_speed
	else:
		hSpeed = -move_speed
		
	# check if we bump into a wall, or if we're on a ledge
	if(is_on_wall() or on_ledge):
		if(current_direction == facing_direction.RIGHT):
			position.x -= 10
			current_direction = facing_direction.LEFT
		else:
			position.x += 10
			current_direction = facing_direction.RIGHT
		update_facing_direction()




func _on_HitBox_area_entered(area):
	queue_free()


func _on_LookRange_body_entered(body):
	if $PlayerDetecter.get_collider() == player:
		player_in_range = true


func _on_LookRange_body_exited(body):
	player_in_range = false
