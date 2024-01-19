extends Node2D

#signal correctly_typed

func _ready():
	$Typed.visible_characters = 0
	
	
func set_text(text: String):
	$Label.text = text
	$Typed.text = text

func type_text(typed: String) -> bool:
	if $Label.text.begins_with(typed):
		$Typed.visible_characters = len(typed)
	else:
		$Typed.visible_characters = 0
	#if $Label.text == typed:
	#	emit_signal("correctly_typed")
	return $Label.text == typed
