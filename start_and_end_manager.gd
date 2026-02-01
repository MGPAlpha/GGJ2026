extends Node

@export var cam_manager: CameraManager
@export var controller: PlayerController
@export var spotlight: SpotLight3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	call_deferred("level_start")

func level_start():
	controller.control_master_enable = false
	spotlight.visible = false
	cam_manager.set_camera_mode_instant(true)
	await get_tree().create_timer(2).timeout
	spotlight.visible = true
	await get_tree().create_timer(1).timeout
	await cam_manager.set_camera_mode(false)
	controller.control_master_enable = true
	
func _on_solved():
	controller.control_master_enable = false
	await cam_manager.set_camera_mode(true)
	await get_tree().create_timer(1.5).timeout
	LevelManager.play_next_level()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
