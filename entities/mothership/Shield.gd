extends Node2D

var color: Color

func _ready() -> void:
	$Sprite2D.modulate = color
