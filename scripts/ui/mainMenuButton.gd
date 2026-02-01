extends Node

@export var background : TextureRect
@export var button : Button
@export var optionMenu : PopupMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.material = background.material.duplicate()
	_offHover()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _onHover() -> void:
	var shaderMaterial = background.material as ShaderMaterial
	
	#shaderMaterial.set_shader_parameter("amplitude", 0.0)
	#print(shaderMaterial.get_shader_parameter("amplitude"))
	
	var tween := get_tree().create_tween()
	tween.tween_method(_set_shader_value, shaderMaterial.get_shader_parameter("amplitude"), 1.0, 2)

func _offHover() -> void:
	var shaderMaterial = background.material as ShaderMaterial
	#print(shaderMaterial.get_shader_parameter("amplitude"))
	var tween := get_tree().create_tween()
	tween.tween_method(_set_shader_value, shaderMaterial.get_shader_parameter("amplitude"), 0.0, 2)
	#shaderMaterial.set_shader_parameter("amplitude", 0.0)
	
func _onQuit() -> void:
	get_tree().quit()

func _onStart() -> void:
#	some functionality to load the level here
	get_tree().change_scene_to_file("res://scenes/jade/LevelSelect.tscn")

func _onOptions() -> void:
#	Some functionality to open up the options here
	# optionMenu.popup_exclusive_centered()
	pass

func _set_shader_value(value: float):
	var shaderMaterial = background.material as ShaderMaterial
	shaderMaterial.set_shader_parameter("amplitude", value)
