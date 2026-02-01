class_name CameraManager extends Node3D

@export var camera: Camera3D
@export var top_down_pos: Node3D
@export var isometric_pos: Node3D

@export var camera_move_time = .8

var using_top_down: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_board_generated(board_center: Vector3):
	print("Board center: ", board_center)
	var top_project_basis = (top_down_pos.quaternion * Vector3.FORWARD).normalized()
	var top_dist_to_board = (top_down_pos.position - board_center).dot(top_project_basis)
	top_down_pos.position = top_dist_to_board * top_project_basis + board_center
	print("topdown pos: ", top_down_pos.position)
	
	var iso_project_basis = (isometric_pos.quaternion * Vector3.FORWARD).normalized()
	var iso_dist_to_board = (isometric_pos.position - board_center).dot(iso_project_basis)
	isometric_pos.position = iso_dist_to_board * iso_project_basis + board_center
	print("iso pos: ", isometric_pos.position)
	
	camera.position = isometric_pos.position
	camera.rotation = isometric_pos.rotation
	
func set_camera_mode(is_top_down: bool):
	using_top_down = is_top_down
	var new_pos = top_down_pos if is_top_down else isometric_pos
	var tween := create_tween()
	tween.set_parallel()
	tween.tween_property(camera, "position", new_pos.position, camera_move_time)
	tween.tween_property(camera, "quaternion", new_pos.quaternion, camera_move_time)
	await tween.finished
	
func set_camera_mode_instant(is_top_down: bool):
	using_top_down = is_top_down
	var new_pos = top_down_pos if is_top_down else isometric_pos
	camera.position = new_pos.position
	camera.quaternion = new_pos.quaternion
	
func toggle_camera_mode():
	await set_camera_mode(!using_top_down)
