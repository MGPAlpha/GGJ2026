class_name PlayerController extends Node

@onready var board: Board = self.get_parent()
@export var camera_manager: CameraManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	

var move_busy = false
var pop_out_active = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("return_to_level_select"):
		LevelManager.return_to_menu()
		return
	if Input.is_action_just_pressed("reload"):
		if LevelManager.reload_level(): return
	if move_busy: return
	if Input.is_action_just_pressed("camera_swap"):
		move_busy = true
		await camera_manager.toggle_camera_mode()
		move_busy = false
	elif !pop_out_active:
		if Input.is_action_just_pressed("move_up"):
			move_busy = true
			await board.try_move_player(Vector2i.UP)
			move_busy = false
		elif Input.is_action_just_pressed("move_down"):
			move_busy = true
			await board.try_move_player(Vector2i.DOWN)
			move_busy = false
		elif Input.is_action_just_pressed("move_left"):
			move_busy = true
			await board.try_move_player(Vector2i.LEFT)
			move_busy = false
		elif Input.is_action_just_pressed("move_right"):
			move_busy = true
			await board.try_move_player(Vector2i.RIGHT)
			move_busy = false
		elif Input.is_action_just_pressed("pop_cube"):
			board.display_cube()
			pop_out_active = true
	else:
		if Input.is_action_just_pressed("move_left"):
			board.rotate_display_cube(Vector2i.LEFT)
		elif Input.is_action_just_pressed("move_right"):
			board.rotate_display_cube(Vector2i.RIGHT)
		elif Input.is_action_just_pressed("move_up"):
			board.rotate_display_cube(Vector2i.UP)
		elif Input.is_action_just_pressed("move_down"):
			board.rotate_display_cube(Vector2i.DOWN)
		elif Input.is_action_just_pressed("pop_cube"):
			move_busy = true
			pop_out_active = false
			await board.end_display_cube()
			move_busy = false
			
