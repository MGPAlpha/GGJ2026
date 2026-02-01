extends Node

var levels: Array[PackedScene]

var curr_level: PackedScene
var curr_level_index: int = -1

func _init() -> void:
	levels = load("res://scenes/Levels/level_list.tres").level_list
	
func _ready() -> void:
	var curr_scene = get_tree().current_scene.scene_file_path
	for i in levels.size():
		if levels[i].resource_path == curr_scene:
			curr_level = levels[i]
			curr_level_index = i
			break

func reload_level():
	if curr_level:
		get_tree().change_scene_to_packed(curr_level)
		return true
	else: return false

func play_level(index): 
	curr_level_index = index
	curr_level = levels[index]
	print(curr_level)
	get_tree().change_scene_to_packed(curr_level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
