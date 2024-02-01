extends CanvasLayer

const stage_text = "Stage {level}-{stage}"

@onready var stage_label = $CenterContainer/VBoxContainer/StageLabel
@onready var location_label = $CenterContainer/VBoxContainer/LocationLabel


func init(stage: int, level: int, location: String):
	set_stage(stage, level)
	set_location(location)


func set_stage(stage: int, level: int) -> void:
	stage_label.text = stage_text.format({"level": str(level), "stage": str(stage)})


func set_location(location: String) -> void:
	location_label.text = location


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "initial":
		self.queue_free()
