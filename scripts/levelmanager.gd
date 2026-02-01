extends Node

var levels: LevelList

var curr_level: PackedScene
var curr_level_index: int = -1

func _init() -> void:
	levels = load("res://scenes/Levels/level_list.tres")
	
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
