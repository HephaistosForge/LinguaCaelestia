extends Area2D

class_name Ship

signal destroyed(int)

@export var max_hp = 100
@export var speed = 3

var language: Language
var index: int
var hp: int
var target_position: Vector2
const rocket_scene = preload("res://entities/projectile/rocket/rocket.tscn")
@onready var mothership = get_tree().get_first_node_in_group("mothership")
@onready var projectile_targets = mothership.get_projectile_targets()

signal enemy_typed_label(Area2D)

func _ready():
	hp = max_hp
	$TypedLabel.connect("correctly_typed", _on_typed_label)
	
func reduce_hp(by):
	hp -= by
	if hp <= 0:
		destroy()
		
func launch_rockets(size, speed, accel, max_speed, damage):
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
			if is_instance_valid(mothership):
				mothership.display_impact_warning(target, rocket, language)
			
func _on_typed_label(ignore):
	emit_signal("enemy_typed_label", self)

func destroy():
	emit_signal("destroyed", index)
	queue_free()

func _physics_process(delta):
	self.global_position -= (self.global_position - target_position) * delta * speed

func set_text(text: String):
	$TypedLabel.set_text(text)
