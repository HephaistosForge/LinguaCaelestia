extends Area2D

signal destroyed(Area2D)

@export var rotation_speed = 3
@export var max_speed = 400
@export var accel = 200
@export var damage = 100
@export var initial_speed = 0
# This is a speed which steadily deacreases after launch and may be larger than
# max speed. It is supposed to enumlate those rockets which are launched 
# first, and then start thrusting
@export var initial_launch_speed = 0
@export var initial_launch_speed_decay_seconds = 0.5
@export var initial_direction = Vector2(0, -1)

var language = Lang.ENGLISH

var explosion_scene = preload("res://vfx/explosion/explosion.tscn")

var seek: Node
var speed = 0
var launch_speed = 0
var direction: Vector2
var allow_rotating = false

@onready var tween = create_tween()

func _ready():
	AudioManager.play_missile_launch()
	
	direction = initial_direction
	speed = initial_speed
	launch_speed = initial_launch_speed
	
	$Warhead.modulate = language.color
	
	var target_scale = self.scale
	self.scale = Vector2.ZERO
	$Particles.emitting = false
	tween.tween_property(self, "scale", target_scale, 0.2)
	tween.tween_property(self, "launch_speed", 0, initial_launch_speed_decay_seconds)
	await get_tree().create_timer(initial_launch_speed_decay_seconds/2.).timeout
	allow_rotating = true
	await get_tree().create_timer(initial_launch_speed_decay_seconds/2.).timeout
	$Particles.emitting = true
	if accel > 0:
		var speed_target_time = (max_speed - speed) / accel
		create_tween().tween_property(self, "speed", max_speed, speed_target_time)

func set_as_enemy_rocket():
	initial_direction = Vector2(0, 1)
	rotate(PI)
	collision_mask = 1 + 8 # Mothership and shields

func _physics_process(delta):
	if not is_instance_valid(seek):
		queue_free()
		return
		
	# speed = min(max_speed, speed+accel*delta)
	global_position += direction * speed * delta
	global_position += initial_direction * launch_speed * delta
	if allow_rotating:
		var target_dir = global_position.direction_to(seek.global_position)
		var new_direction = (direction + target_dir * delta * rotation_speed).normalized()
		rotate(direction.angle_to(new_direction))
		direction = new_direction

func is_same_or_parent_of(parent, child) -> bool:
	if child == null:
		return false
	if parent == child:
		return true
	return is_same_or_parent_of(parent, child.get_parent())
	
func destroy():
	var explosion = explosion_scene.instantiate()
	explosion.set_dir(direction)
	explosion.position = position
	# explosion.scale = scale
	add_sibling(explosion)
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	destroyed.emit(self)
	$Particles.emitting = false
	var tween2 = create_tween()
	tween2.tween_property(self, "scale", Vector2.ZERO, 0.15) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	await tween2.finished
	# Wait until particles have despawned, as this looks cleaner
	await $Particles.finished
	queue_free()
		
func _on_area_entered(area):
	if area.is_in_group("shield"):
		if area.get_parent().language.language == language.language:
			AudioManager.play_shield_hit()
			destroy()
			return
	elif is_same_or_parent_of(area, seek):
		area.reduce_hp(damage)
		AudioManager.play_missile_hit()
		destroy()
		return

