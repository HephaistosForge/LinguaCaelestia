extends Area2D

class_name Ship

@export var max_hp = 100
@export var speed = 3

signal destroyed(int)

var index: int
var hp: int
var target_position: Vector2

func _ready():
	hp = max_hp
	#$TypedLabel.connect("typed_label", destroy)
	
func reduce_hp(by):
	hp -= by
	if hp <= 0:
		destroy()

func destroy():
	emit_signal("destroyed", index)
	queue_free()

func _physics_process(delta):
	self.global_position -= (self.global_position - target_position) * delta * speed

func set_text(text: String):
	$TypedLabel.set_text(text)
