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
const explosion_scene = preload("res://vfx/explosion/ship_explosion.tscn")
@onready var mothership = get_tree().get_first_node_in_group("mothership")
var projectile_targets: Array
var target_override = null
@export var breathing_time = 2.0

@export var rocket_size: float = 1
@export var rocket_accel: float = 25
@export var rocket_initial_speed: float = 0
@export var rocket_launch_speed: float = 0
@export var rocket_launch_speed_decay_seconds: float = 1
@export var rocket_max_speed: float = 50
@export var rocket_rotation_speed: float = 1
@export var rocket_damage: float = 50


signal enemy_typed_label(Area2D)

func _ready():
	configure_rocket_parameters()
	hp = max_hp
	$TypedLabel.connect("correctly_typed", _on_typed_label)
	if is_instance_valid(mothership):
		projectile_targets = mothership.get_projectile_targets()
	$TypedLabel.set_color(language.color)
	AudioManager.play_ship_arrive()
	
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ONE * 1.1, breathing_time) \
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", Vector2.ONE, breathing_time) \
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.set_loops(9999)
	
func configure_rocket_parameters():
	pass
	
func reduce_hp(by):
	hp -= by
	if hp <= 0:
		destroy()
		
func launch_rockets():
	if not is_instance_valid(mothership):
		return
		
	var target = projectile_targets[randi() % len(projectile_targets)]
	if target_override != null:
		target = target_override
		
	for child in get_children():
		if child.is_in_group("enemy_rocket_launch_position"):
			var rocket = rocket_scene.instantiate()
			rocket.set_as_enemy_rocket()
			rocket.damage = rocket_damage
			rocket.scale = Vector2.ONE * rocket_size
			rocket.initial_launch_speed = rocket_launch_speed
			rocket.initial_speed = rocket_initial_speed
			rocket.accel = rocket_accel
			rocket.max_speed = rocket_max_speed
			rocket.rotation_speed = rocket_rotation_speed
			
			rocket.seek = target
			rocket.language = language
			add_sibling(rocket)
			rocket.global_position = child.global_position
			if is_instance_valid(mothership):
				mothership.display_impact_warning(target, rocket, language)
			
func _on_typed_label(_ignore):
	emit_signal("enemy_typed_label", self)

func destroy():
	emit_signal("destroyed", index)
	var explosion = explosion_scene.instantiate()
	explosion.position = position
	add_sibling(explosion)
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(0.3, 0.3, 0.3, 0.8), 0.15)
	tween.tween_property(self, "modulate", Color(0.0, 0.0, 0.0, 0.0), 0.35)
	tween.tween_callback(queue_free)

func _physics_process(delta):
	self.global_position -= (self.global_position - target_position) * delta * speed

func set_text(text: String):
	$TypedLabel.set_text(text)
