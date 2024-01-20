extends Node2D

signal correctly_typed(Node2D)

@export var color: Color = Color.RED

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

func _ready():
	$Typed.visible_characters = 0
	$Typed.modulate = color
	
	
func set_text(text: String):
	$Label.text = text
	$Typed.text = text
	
func normalized_string(string: String):
	string = string.to_lower()
	for i in range(len(string)):
		string[i] = map_weird_chars.get(string[i], string[i])
	return string.strip_edges()


func type_text(typed: String) -> bool:
	var text = normalized_string($Label.text)
	typed = normalized_string(typed)
	if text.begins_with(typed):
		$Typed.visible_characters = len(typed)
	else:
		$Typed.visible_characters = 0
	if text == typed:
		emit_signal("correctly_typed", self)
		return true
	return false
