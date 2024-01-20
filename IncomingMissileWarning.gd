extends Node2D

@onready var icon = $Icon
@onready var typed_label = $TypedLabel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(icon, "scale", Vector2(1.3, 1.3), 0.7).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(icon, "scale", Vector2(1.0, 1.0), 0.7).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.set_loops()

func set_input_text(text: String):
	typed_label.set_text(text)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
