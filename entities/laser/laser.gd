extends Node2D

var starting_point
var end_point

var speed
var target_position: Vector2 = Vector2(500, 500)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.look_at(target_position)
	$Sprite2D.scale.y = self.global_position.distance_to(target_position) / $Sprite2D.texture.get_size().y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func fire():
	pass
