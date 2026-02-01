class_name BoardTile extends Node3D

@export var default_color: Color = Color.WHITE

@export var basic_canvas: Node3D
@export var basic_canvas_mesh: MeshInstance3D
@export var source_basin: Node3D
@export var source_basin_mesh: MeshInstance3D
@export var clean_tile : Node3D
@export var inert_tile: Node3D
@export var inert_tile_mesh: MeshInstance3D

var basic_material: ShaderMaterial
var source_material: ShaderMaterial
var clean_material: StandardMaterial3D
var inert_material: ShaderMaterial

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	basic_material = basic_canvas_mesh.material_override.duplicate()
	basic_canvas_mesh.material_override = basic_material
	basic_material.set_shader_parameter("CanvasColor", default_color)
	basic_canvas.visible = false
	
	source_material = source_basin_mesh.material_override.duplicate()
	source_basin_mesh.material_override = source_material
	source_material.set_shader_parameter("PaintColor", default_color)
	source_material.set_shader_parameter("RandomID", randf())
	source_basin.visible = false
	
	clean_tile.visible = false
	
	inert_tile.visible = false
	inert_material = inert_tile_mesh.material_override.duplicate()
	inert_tile_mesh.material_override = inert_material
	inert_material.set_shader_parameter("CanvasColor", default_color)

func set_color(color: Color):
	basic_material.set_shader_parameter("CanvasColor", color)
	source_material.set_shader_parameter("PaintColor", color)
	inert_material.set_shader_parameter("CanvasColor", color)
	
func set_mode(mode: BoardTileData.TileMode):
	print(mode)
	match mode:
		BoardTileData.TileMode.BASIC:
			basic_canvas.visible = true
		BoardTileData.TileMode.SOURCE:
			source_basin.visible = true
		BoardTileData.TileMode.CLEAN:
			clean_tile.visible = true
		BoardTileData.TileMode.INERT:
			inert_tile.visible = true
