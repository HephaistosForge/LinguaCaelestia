extends Area2D

signal player_death

var max_hp = 1000
var hp = 1000

@onready var health_progress_bar = $HealthProgressBar
var base_color = Color.AQUAMARINE

func _ready():
	var initial_pos = position
	self.position.y += 400
	create_tween().tween_property(self, "position", initial_pos, 1) \
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	update_hp_visually()
	


func get_projectile_targets() -> Array[Node]:
	return $ProjectileTargets.get_children()


func display_impact_warning(projectile_target: Node2D, weapon: Node2D, language: Language) -> void:
	if not projectile_target is Marker2D:
		return
	projectile_target.add_incoming_missile(weapon, language, projectile_target.get_index())


func reduce_hp(val: int) -> void:
	self.hp -= val
	self.hp = clamp(self.hp, 0, max_hp)
	update_hp_visually()
	if self.hp == 0:
		self.handle_death()


func heal(val: int) -> void:
	self.hp += val
	self.hp = clamp(self.hp, 0, max_hp)
	update_hp_visually()


func update_hp_visually():
	#var darkened_factor = 1 - (float(hp)/float(max_hp))
	#health_sprite.modulate = base_color.darkened(0.8 * darkened_factor)
	var tween = create_tween()
	tween.tween_property(health_progress_bar, "value", hp, .5) \
		.set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	# health_progress_bar.value = hp

func handle_death() -> void:
	player_death.emit()
	
	self.queue_free()



