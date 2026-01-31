class_name BoardTile extends Node3D

@export var default_color: Color = Color.WHITE

@export var mesh_renderer: MeshInstance3D

var material: StandardMaterial3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	material = StandardMaterial3D.new()
	mesh_renderer.material_override = material
	material.albedo_color = default_color

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_color(color: Color):
	material.albedo_color = color
