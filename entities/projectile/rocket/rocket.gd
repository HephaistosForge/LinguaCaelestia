extends Area2D


@export var rotation_speed = 3
@export var max_speed = 400
@export var accel = 200
@export var damage = 100

var explosion_scene = preload("res://vfx/explosion/explosion.tscn")

var seek: Node
var speed = 200
var direction = Vector2(0, -1)

func set_as_enemy_rocket():
	direction = Vector2(0, 1)
	rotate(PI)
	collision_mask = 1

func _physics_process(delta):
	speed = min(max_speed, speed+accel*delta)
	global_position += direction * speed * delta
	var target_dir = global_position.direction_to(seek.global_position)
	var new_direction = (direction + target_dir * delta * rotation_speed).normalized()
	rotate(direction.angle_to(new_direction))
	direction = new_direction

func is_same_or_parent_of(parent, child) -> bool:
	if parent == null:
		return false
	if parent == child:
		return true
	return is_same_or_parent_of(parent, child.get_parent())

func _on_area_entered(area):
	if is_same_or_parent_of(area, seek):
		# area.reduce_hp(damage) # TODO mothership
		var explosion = explosion_scene.instantiate()
		explosion.position = position
		add_sibling(explosion)
		queue_free()
