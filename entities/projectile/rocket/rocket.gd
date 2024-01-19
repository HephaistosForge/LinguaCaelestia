extends Area2D


@export var rotation_speed = 3
@export var max_speed = 400
@export var accel = 200

var explosion_scene = preload("res://vfx/explosion/explosion.tscn")

var seek: Node
var speed = 200
var direction = Vector2(0, -1)

func _physics_process(delta):
	speed = min(max_speed, speed+accel*delta)
	#position -= (position - seek.position).normalized() * delta * speed
	position += direction * speed * delta
	var target_dir = position.direction_to(seek.position)
	var new_direction = (direction + target_dir * delta * rotation_speed).normalized()
	rotate(direction.angle_to(new_direction))
	direction = new_direction


func _on_area_entered(area):
	print_debug(area, seek)
	if area == seek:
		print_debug("Hit")
		area.reduce_hp(100)
		var explosion = explosion_scene.instantiate()
		explosion.position = position
		add_sibling(explosion)
		queue_free()
