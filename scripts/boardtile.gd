class_name BoardTile extends Node3D

@export var default_color: Color = Color.WHITE

@export var basic_mesh: MeshInstance3D
@export var source_mesh: MeshInstance3D
@export var clean_mesh: MeshInstance3D
@export var inert_mesh: MeshInstance3D

var basic_material: StandardMaterial3D
var source_material: StandardMaterial3D
var clean_material: StandardMaterial3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	basic_material = StandardMaterial3D.new()
	basic_mesh.material_override = basic_material
	basic_material.albedo_color = default_color
	basic_mesh.visible = false
	source_material = StandardMaterial3D.new()
	source_mesh.material_override = source_material
	source_material.albedo_color = default_color
	source_mesh.visible = false
	clean_material = StandardMaterial3D.new()
	clean_mesh.material_override = clean_material
	clean_material.albedo_color = default_color
	clean_mesh.visible = false
	inert_mesh.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_color(color: Color):
	basic_material.albedo_color = color
	source_material.albedo_color = color
	
func set_mode(mode: BoardTileData.TileMode):
	print(mode)
	match mode:
		BoardTileData.TileMode.BASIC:
			basic_mesh.visible = true
		BoardTileData.TileMode.SOURCE:
			source_mesh.visible = true
		BoardTileData.TileMode.CLEAN:
			clean_mesh.visible = true
		BoardTileData.TileMode.INERT:
			inert_mesh.visible = true
