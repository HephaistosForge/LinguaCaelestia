extends Sprite2D

var mothership: Node2D
var speed = 30
@onready var typed_label = $TypedLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mothership = get_tree().get_first_node_in_group("mothership")
	typed_label.set_text("repair")
	typed_label.set_color(Color.AQUAMARINE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.global_position.y > 750:
		despawn()
		return
	self.global_position = global_position.move_toward(Vector2(global_position.x, 800), delta * speed)
	

func despawn():
	self.queue_free()


func _on_typed_label_correctly_typed(_ignored) -> void:
	if is_instance_valid(mothership):
		mothership.heal(500)
	self.queue_free()
