extends Area2D

signal player_death

var max_hp = 1000
var hp = 1000

@onready var health_sprite = $HealthSpriteModulate
var base_color = Color.AQUAMARINE

func _ready():
	var initial_pos = position
	self.position.y += 400
	create_tween().tween_property(self, "position", initial_pos, 1) \
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	modulate_health_sprite()
	


func get_projectile_targets() -> Array[Node]:
	return $ProjectileTargets.get_children()


func display_impact_warning(projectile_target: Node2D, weapon: Node2D, language: Language) -> void:
	if not projectile_target is Marker2D:
		return
	projectile_target.add_incoming_missile(weapon, language, projectile_target.get_index())


func reduce_hp(val: int) -> void:
	self.hp -= val
	self.hp = clamp(self.hp, 0, max_hp)
	modulate_health_sprite()
	if self.hp == 0:
		self.handle_death()


func heal(val: int) -> void:
	self.hp += val
	self.hp = clamp(self.hp, 0, max_hp)
	modulate_health_sprite()


func modulate_health_sprite():
	var darkened_factor = 1 - (float(hp)/float(max_hp))
	health_sprite.modulate = base_color.darkened(0.8 * darkened_factor)

func handle_death() -> void:
	player_death.emit()
	
	self.queue_free()



