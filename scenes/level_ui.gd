extends Control
@onready var top_camera: TextureRect = $HBoxContainer/TopCamera
@onready var iso_camera: TextureRect = $HBoxContainer/IsoCamera




func _on_camera_manager_camera_mode_changed(top_down: bool) -> void:
	top_camera.visible = top_down
	iso_camera.visible = not top_down
