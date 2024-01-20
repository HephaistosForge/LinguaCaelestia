extends Node2D

@onready var icon = $Icon
@onready var typed_label = $TypedLabel
var tween
var weapons = []


signal on_dismiss


func _ready() -> void:
	tween = create_tween()
	tween.tween_property(icon, "scale", Vector2(1.3, 1.3), 0.7).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(icon, "scale", Vector2(1.0, 1.0), 0.7).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.set_loops(999)


func init(language: Language, color: Color, text: String, weapon: Node2D, parent: Node2D) -> void:
	typed_label.set_text(text)
	typed_label.set_language(language)
	icon.modulate = color
	add_weapon(weapon)
	typed_label.correctly_typed.connect(parent._on_correctly_typed)
	typed_label.set_color(color)
	

func add_weapon(weapon):
	self.weapons.append(weapon)
	weapon.destroyed.connect(_on_weapon_destroyed)


func dismiss_warning():
	on_dismiss.emit(self)
	if tween.is_running:
		tween.kill()
	self.queue_free()


func _on_weapon_destroyed(_weapon_ref):
	self.weapons.erase(_weapon_ref)
	if self.weapons.is_empty():
		dismiss_warning()
