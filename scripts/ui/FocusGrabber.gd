extends Node

@export var control_to_focus : Control

func _ready():
	
	control_to_focus.grab_focus()
	
	
