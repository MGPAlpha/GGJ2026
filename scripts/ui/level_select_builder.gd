extends Node

@export var level_button_grid: GridContainer
@export var level_button_prefab: PackedScene

func _ready():
	var levels = LevelManager.levels
	for i in levels.size():
		var new_button = level_button_prefab.instantiate()
		new_button.button.pressed.connect(func(): LevelManager.play_level(i))
		new_button.button.text = str(i+1)
		level_button_grid.add_child(new_button)
