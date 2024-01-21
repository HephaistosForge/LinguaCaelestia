extends Node2D

signal correctly_typed(Node2D)

@export var color: Color = Color.RED
var language: Language

var map_weird_chars = {
	"â": "a",
	"ä": "a",
	"é": "e",
	"è": "e",
	"ê": "e",
	"ē": "e",
	"ʻ": "'",
	"`": "'",
	"ô": "o",
	"ö": "o",
	"ō": "o",
	"ü": "u",
}

func set_horizontal_alignment(alignment):
	$Label.horizontal_alignment = alignment
	$Typed.horizontal_alignment = alignment
	var anchor = Control.PRESET_CENTER
	match alignment:
		HORIZONTAL_ALIGNMENT_LEFT:
			anchor = Control.PRESET_CENTER_RIGHT
		HORIZONTAL_ALIGNMENT_RIGHT:
			anchor = Control.PRESET_CENTER_LEFT
	$Typed.anchors_preset = anchor
	$Label.anchors_preset = anchor

func _ready():
	$Typed.visible_characters = 0
	$Typed.modulate = color


func set_text(text: String):
	$Label.text = text
	$Typed.text = text


func set_color(_color: Color):
	self.color = _color
	$Typed.modulate = self.color
	

func set_language(_language: Language):
	self.language = _language


func normalized_string(string: String):
	string = string.to_lower()
	for i in range(len(string)):
		string[i] = map_weird_chars.get(string[i], string[i])
	return string.strip_edges()

func animate_typed(text, typed):
	var percent = 1.0 * len(typed) / len(text)
	var new_rotation = 0
	if len(typed) != 0:
		new_rotation = deg_to_rad(3) * (-1 if len(typed) % 2 == 1 else 1)
	var size = Vector2.ONE * (1 + 0.5 * percent)
	create_tween().tween_property(self, "scale", size, 0.1) \
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	create_tween().tween_property(self, "rotation", new_rotation, 0.1) \
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func animate_disappear():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.5) \
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	await tween.finished
	if is_instance_valid(self):
		self.modulate = Color.TRANSPARENT

func type_text(typed: String) -> bool:
	var text = normalized_string($Label.text)
	typed = normalized_string(typed)
	if text.begins_with(typed):
		animate_typed(text, typed)
		$Typed.visible_characters = len(typed)
	else:
		$Typed.visible_characters = 0

	if text == typed:
		animate_disappear()
		correctly_typed.emit(self)
		return true
	return false
