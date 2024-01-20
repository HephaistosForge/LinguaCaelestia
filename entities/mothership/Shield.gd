extends Node2D

var color: Color
var language: Language

func _ready() -> void:
	$Sprite2D.modulate = color


func _on_timer_timeout() -> void:
	self.queue_free()
