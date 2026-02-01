extends TextureRect

@export var move_label: Label
@export var top_camera: TextureRect


var move_count : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _increaseMoveCount():
	move_count += 1
	move_label.text = str(move_count)
	
func _clearMoveCount():
	move_count = 0
	move_label.text = str(move_count)
	
