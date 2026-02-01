extends Node

@export var background : TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.material = background.material.duplicate()
	_offHover()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _onHover() -> void:
	var shaderMaterial = background.material as ShaderMaterial
	shaderMaterial.set_shader_parameter("amplitude", 1.0)
	print(shaderMaterial.get_shader_parameter("amplitude"))
	
func _offHover() -> void:
	var shaderMaterial = background.material as ShaderMaterial
	shaderMaterial.set_shader_parameter("amplitude", 0.0)
