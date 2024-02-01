extends CanvasLayer

const stage_text = "Stage {stage}-{level}"

@onready var stage_label = $CenterContainer/VBoxContainer/StageLabel
@onready var location_label = $CenterContainer/VBoxContainer/LocationLabel


func init(stage: int, level: int, location: String):
	set_stage(stage, level)
	set_location(location)


func set_stage(stage: int, level: int) -> void:
	stage_label.text = stage_text.format({"stage": str(stage), "level": str(level)})


func set_location(location: String) -> void:
	location_label.text = location
