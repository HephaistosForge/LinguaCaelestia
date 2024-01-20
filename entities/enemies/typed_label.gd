extends Node2D

signal correctly_typed(Node2D)

@export var color: Color = Color.RED

func _ready():
	$Typed.visible_characters = 0
	$Typed.modulate = color
	
	
func set_text(text: String):
	$Label.text = text
	$Typed.text = text

func type_text(typed: String) -> bool:
	if $Label.text.begins_with(typed):
		$Typed.visible_characters = len(typed)
	else:
		$Typed.visible_characters = 0
	if $Label.text == typed:
		print_debug("hello")
		emit_signal("correctly_typed", self)
	return $Label.text == typed
