class_name PlayerController extends Node

@onready var board: Board = self.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	

var move_busy = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if move_busy: return
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
