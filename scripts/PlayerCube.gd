class_name PlayerCube extends Node3D

@export var cube_angles : Quaternion
@export var cube : Node3D
@export var pivot_point : Node3D
@export var cube_side_length : float
@export var roll_speed : float
@export var default_color: Color = Color.WHITE

@export var cube_sides: Dictionary[Vector3i, MeshInstance3D] = {
	Vector3i.UP: null,
	Vector3i.DOWN: null,
	Vector3i.LEFT: null,
	Vector3i.RIGHT: null,
	Vector3i.FORWARD: null,
	Vector3i.BACK: null
}

func _ready() -> void:
	print("Ran ready")
	#for side in cube_sides:
		#cube_sides[side].material_override = StandardMaterial3D.new()

func rotate_cube(new_position : Vector3, new_quaternion : Quaternion):
#	Implemented using this post as the basis.
#	https://www.reddit.com/r/godot/comments/17pf75f/how_do_you_correctly_roll_a_cube_with_tweens_in/
#	This line here doesn't make sense, need to refactor
	#var rotation_basis = pivot_point.basis
	#var transformed_input : Vector3 = rotation_basis * global_transform.basis * Vector3(direction.x, 0, direction.y) 
	#var roll_destination := position + transformed_input * cube_side_length
	
	#var roll_basis : Basis = Basis()
	#roll_basis = roll_basis.rotated(Vector3(1, 0, 0), deg_to_rad(90) * sign(direction.y))
	#roll_basis = roll_basis.rotated(Vector3(0, 0, 1), deg_to_rad(90) * -sign(direction.x))
	#roll_basis = rotation_basis * roll_basis * cube.global_transform.basis
	#roll_basis = roll_basis.orthonormalized()
	
	var tween := create_tween()
	tween.set_parallel()
	tween.tween_property(self, "position", new_position, roll_speed)
	tween.tween_property(cube, "quaternion", new_quaternion, roll_speed)
	#tween.tween_method(roll.bind(rotation_basis * cube.global_transform.basis, roll_basis), 0.0, 1.0, roll_speed)
	tween.tween_method(roll_height, 0.0, 1.0, roll_speed)
	await tween.finished

func roll(w: float, f: Basis, t: Basis) -> void:
	cube.global_transform.basis = f.slerp(t, w)

func roll_height(w: float) -> void:
	var x = (w - 0.5)
	var h = cube_side_length / 2.0 * cosh(1) - cube_side_length / 2.0 * cosh(x / (cube_side_length / 2.0))
	cube.transform.origin.y = h

func set_face_color(face: Vector3i, color_index: int, color_list: Array[Color]):
	var color = color_list[color_index] if color_index >= 0 else default_color
	var material = cube_sides[face].material_override as ShaderMaterial

	material.set_shader_parameter("PaintColor", color)

func wait():  
	await get_tree().create_timer(2).timeout
	
