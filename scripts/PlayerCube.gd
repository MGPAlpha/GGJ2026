class_name PlayerCube extends Node3D

@export var accessibility_textures : Array[Node3D]

@export var audio_player : AudioStreamPlayer3D

@export var cube_angles : Quaternion
@export var cube : Node3D
@export var pivot_point : Node3D
@export var cube_side_length : float
@export var roll_speed : float
@export var rotate_speed : float
@export var default_color: Color = Color.WHITE
@export var default_pattern: Texture2D = preload("uid://bk45nmg2csjo3")

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
	for i in range(accessibility_textures.size()):
		accessibility_textures[i].visible = SettingsManager.is_colorblind
		
	#for side in cube_sides:
		#cube_sides[side].material_override = StandardMaterial3D.new()

func rotate_cube(new_position : Vector3, new_quaternion : Quaternion):
#	Implemented using this post as the basis.
#	https://www.reddit.com/r/godot/comments/17pf75f/how_do_you_correctly_roll_a_cube_with_tweens_in/
#	This line here doesn't make sense, need to refactor	
	var tween := create_tween()
	tween.set_parallel()
	tween.tween_property(self, "position", new_position, roll_speed)
	tween.tween_property(cube, "quaternion", new_quaternion, roll_speed)
	tween.tween_method(roll_height, 0.0, 1.0, roll_speed)
	await tween.finished
	playNote()
	

func roll(w: float, f: Basis, t: Basis) -> void:
	cube.global_transform.basis = f.slerp(t, w)

func roll_height(w: float) -> void:
	var x = (w - 0.5)
	var h = cube_side_length / 2.0 * cosh(1) - cube_side_length / 2.0 * cosh(x / (cube_side_length / 2.0))
	cube.transform.origin.y = h

func set_face_color(face: Vector3i, color_index: int, color_list: Array[Array]):
	var color = color_list[color_index][0] if color_index >= 0 else default_color
	var pattern = color_list[color_index][1] if color_index >= 0 else default_pattern
	
	var material = cube_sides[face].material_override as ShaderMaterial
	material.set_shader_parameter("PaintColor", color)
	
	var sprite = cube_sides[face].get_child(0) as Sprite3D
	sprite.texture = pattern

func wait():  
	await get_tree().create_timer(2).timeout

func pop_out_cube(new_position: Vector3, new_rotation: Quaternion):
	var tween := create_tween()
	tween.set_ease(tween.EASE_OUT)
	tween.set_parallel()
	tween.tween_property(self, "position", new_position, rotate_speed)
	tween.tween_property(cube, "quaternion", new_rotation, rotate_speed)
	await tween.finished
	
func playNote() -> void:
	var notes = [-2, -4, -5, 0, 2, 4, 5, 7, 9, 11, 12]
	# var rand_pitch = 1.0 + (float(randi_range(-6, 6)) * pow(2.0, 1.0/12.0)) / 12.0
	var note = notes[randi() % notes.size()]
	var rand_pitch = 1.0 + (pow(2.0, float(abs(note))/12.0) - 1.0) * sign(note)
	# var rand_pitch = 1.0 + (pow(2.0, float(randi() % 13)/12.0) - 1.0)
	AudioServer.get_bus_effect(AudioServer.get_bus_index("Player"), 0).set("pitch_scale", rand_pitch)
	audio_player.play(0.0)
	print("Honk Pitch: ", rand_pitch)
