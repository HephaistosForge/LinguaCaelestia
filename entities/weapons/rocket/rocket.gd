extends Weapon

var stats: RocketStats = RocketStats.new()

const EXPLOSION_SCENE = preload("res://vfx/explosion/explosion.tscn")

var speed = 0
var launch_speed = 0
var initial_direction = Vector2(0, -1)
var direction: Vector2
var allow_rotating = false


@onready var tween = create_tween()

func init(stats: RocketStats, seek: Node2D, language: Language, is_enemy: bool):
	self.scale = Vector2.ONE * stats.size
	self.stats = stats
	self.seek = seek
	self.language = language
	if is_enemy:
		self._set_as_enemy_rocket()

func _ready():
	AudioManager.play_missile_launch()
	
	direction = initial_direction
	speed = stats.initial_speed
	launch_speed = stats.initial_launch_speed
	
	$Warhead.modulate = language.color
	
	var target_scale = self.scale
	self.scale = Vector2.ZERO
	$Particles.emitting = false
	tween.tween_property(self, "scale", target_scale, 0.2)
	tween.tween_property(self, "launch_speed", 0, stats.initial_launch_speed_decay_seconds)
	await get_tree().create_timer(stats.initial_launch_speed_decay_seconds/2.).timeout
	allow_rotating = true
	await get_tree().create_timer(stats.initial_launch_speed_decay_seconds/2.).timeout
	$Particles.emitting = true
	if stats.accel > 0:
		var speed_target_time = (stats.max_speed - speed) / stats.accel
		create_tween().tween_property(self, "speed", stats.max_speed, speed_target_time)

func _set_as_enemy_rocket():
	initial_direction = Vector2(0, 1)
	rotation = PI
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
		var new_direction = (direction + target_dir * delta * stats.rotation_speed).normalized()
		rotate(direction.angle_to(new_direction))
		direction = new_direction

func is_same_or_parent_of(parent, child) -> bool:
	if child == null:
		return false
	if parent == child:
		return true
	return is_same_or_parent_of(parent, child.get_parent())
	
func destroy():
	var explosion = EXPLOSION_SCENE.instantiate()
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
			area.get_parent().rocket_hit()
			destroy()
			return
	elif is_same_or_parent_of(area, seek):
		area.reduce_hp(stats.damage)
		AudioManager.play_missile_hit()
		destroy()
		return

