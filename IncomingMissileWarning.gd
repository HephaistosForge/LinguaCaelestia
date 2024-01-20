extends Node2D

@onready var icon = $Icon
@onready var typed_label = $TypedLabel
var tween


func _ready() -> void:
	tween = get_tree().create_tween()
	tween.tween_property(icon, "scale", Vector2(1.3, 1.3), 0.7).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(icon, "scale", Vector2(1.0, 1.0), 0.7).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.set_loops(999)


func init(color: Color, text: String, weapon: Node2D) -> void:
	typed_label.set_text(text)
	icon.modulate = color
	weapon.destroyed.connect(_on_weapon_destroyed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_weapon_destroyed(_weapon_ref):
	if tween.is_running:
		tween.kill()
	self.queue_free()
