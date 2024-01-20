extends Area2D

class_name Ship

@export var max_hp = 100
@export var speed = 3

signal destroyed(int)

var index: int
var hp: int
var target_position: Vector2
var rocket_scene = preload("res://entities/projectile/rocket/rocket.tscn")
var projectile_targets: Array

func _ready():
	hp = max_hp
	projectile_targets = get_tree().get_first_node_in_group("mothership").get_projectile_targets()
	#$TypedLabel.connect("typed_label", destroy)
	
func reduce_hp(by):
	hp -= by
	if hp <= 0:
		destroy()
		
func launch_rockets(size, max_speed):
	var target = projectile_targets[randi() % len(projectile_targets)]
	for child in get_children():
		if child.is_in_group("enemy_rocket_launch_position"):
			var rocket = rocket_scene.instantiate()
			rocket.global_position = child.global_position
			rocket.set_as_enemy_rocket()
			rocket.scale = Vector2(size, size)
			rocket.max_speed = max_speed
			rocket.seek = target
			add_sibling(rocket)

func destroy():
	emit_signal("destroyed", index)
	queue_free()

func _physics_process(delta):
	self.global_position -= (self.global_position - target_position) * delta * speed

func set_text(text: String):
	$TypedLabel.set_text(text)
