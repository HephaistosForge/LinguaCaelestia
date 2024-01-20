extends Node2D

var color: Color
var language: Language

func _ready() -> void:
	$Sprite2D.modulate = color
	var initial_scale = scale
	self.scale = Vector2.ZERO
	create_tween().tween_property(self, "scale", initial_scale, 0.3) \
		.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)


func _on_timer_timeout() -> void:
	self.queue_free()
