extends Area2D

signal player_death

const ROCKET_SCENE = preload("res://entities/weapons/rocket/rocket.tscn")

@export var rocket_stats: RocketStats = RocketStats.new()

@onready var health_progress_bar = $HealthProgressBar
@onready var health_effect = $HealthEffect

var max_hp = 1000
var hp = 1000
var base_color = Color.AQUAMARINE

func _ready():
	var initial_pos = position
	self.position.y += 400
	create_tween().tween_property(self, "position", initial_pos, 1) \
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	health_progress_bar.max_value = max_hp
	update_hp_visually()


func launch_rocket_at_node(node: Node) -> void:
	var rocket_launch_pos = get_tree().get_first_node_in_group("rocket_launch_position")
	if is_instance_valid(rocket_launch_pos):
		var rocket = ROCKET_SCENE.instantiate()
		rocket.init(rocket_stats, node, Lang.ENGLISH, false)
		add_child(rocket)
		rocket.global_position = rocket_launch_pos.global_position


func get_projectile_targets() -> Array[Node]:
	return $ProjectileTargets.get_children()


func display_impact_warning(projectile_target: Node2D, weapon: Node2D, language: Language) -> void:
	if not projectile_target is Marker2D:
		return
	projectile_target.add_incoming_missile(weapon, language, projectile_target.get_index())


func reduce_hp(val: int) -> void:
	var new_hp = clamp(self.hp - val, 0, max_hp)
	var changed_by = new_hp - self.hp
	self.hp = new_hp
	update_hp_visually(changed_by)

	if self.hp == 0:
		self.handle_death()


func heal(val: int) -> void:
	reduce_hp(-val)


func update_hp_visually(hp_changed_by=0):
	#var darkened_factor = 1 - (float(hp)/float(max_hp))
	#health_sprite.modulate = base_color.darkened(0.8 * darkened_factor)
	create_tween().tween_property(health_progress_bar, "value", hp, .3) \
		.set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	_add_hp_effect(hp_changed_by)
	
func _add_hp_effect(hp_changed_by):
	var effect = health_effect.duplicate()
	var tween = create_tween()
	effect.modulate = Color.GREEN if hp_changed_by > 0 else Color.RED
	effect.self_modulate = Color(1, 1, 1, 0.3)
	add_child(effect)
	effect.position = health_effect.position
	var factor = 1 + log(abs(hp_changed_by)) / log(10) / 2
	tween.tween_property(effect, "scale", effect.scale * factor, .1) \
		.set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_property(effect, "self_modulate", Color.TRANSPARENT, .1) \
		.set_trans(Tween.TRANS_LINEAR)
	tween.finished.connect(func(): effect.queue_free())


func handle_death() -> void:
	player_death.emit()
	
	self.queue_free()



