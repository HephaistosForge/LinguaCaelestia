extends Node2D

var color: Color
var language: Language

func _ready() -> void:
	$Sprite.material.set_shader_parameter("shield_color", color)

func rocket_hit():
	if $AnimationPlayer.current_animation == "hit":
		$AnimationPlayer.seek(0)
	else:
		$AnimationPlayer.play("hit")

func _on_timer_timeout() -> void:
	$AnimationPlayer.play("kill")

