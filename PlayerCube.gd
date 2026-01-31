extends Node3D

@export var cube_angles : Quaternion
@export var cube_faces : Node3D

func _enter_tree():
	rotate_cube(Vector3(0, 0,0), cube_angles)

func rotate_cube(new_position : Vector3, new_rotation : Quaternion):
#	Needs to know what tile it is rolling to
# 	Give it a quaternion, lerp from existing quaternion to new one.
	var curr_quaternion = cube_faces.quaternion
	var ans = curr_quaternion.slerp(new_rotation.normalized(), 0.5).normalized()
	cube_faces.quaternion = ans
	#printerr("rotate_cube() currently not implemented")
	

func set_face():
#	Use local coordinates, or enum, 
	printerr("set_face() not implemented")
