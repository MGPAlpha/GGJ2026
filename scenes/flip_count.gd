extends TextureRect

@export var move_label: Label

var move_count : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _set_move_count(count: int):
	move_count = count
	move_label.text = str(move_count)
	
