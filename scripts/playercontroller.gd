class_name PlayerController extends Node

@onready var board: Board = self.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	

var pop_out_active = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !pop_out_active:
		if Input.is_action_just_pressed("move_up"):
			board.try_move_player(Vector2i.UP)
		elif Input.is_action_just_pressed("move_down"):
			board.try_move_player(Vector2i.DOWN)
		elif Input.is_action_just_pressed("move_left"):
			board.try_move_player(Vector2i.LEFT)
		elif Input.is_action_just_pressed("move_right"):
			board.try_move_player(Vector2i.RIGHT)
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
			board.end_display_cube()
			pop_out_active = false
			
