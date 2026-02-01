extends Control

@export var master_slider : HSlider
@export var music_slider : HSlider
@export var sound_effects_slider : HSlider

@export var options_container : Control
@export var credits_container : Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_hideOptionsMenu()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _showOptionsMenu() -> void:
	visible = true
	
func _hideOptionsMenu() -> void:
	visible = false
	_hideCredits()
	
func _showCredits() -> void:
	options_container.visible = false
	credits_container.visible = true
	
func _hideCredits() -> void:
	options_container.visible = true
	credits_container.visible = false
	
func _changeMasterVolume(volume : float) -> void:
	_changeVolume(volume, "Master")
	
func _changeMusicVolume(volume : float) -> void:
	_changeVolume(volume, "Music")
	
func _changeSoundEffectVolume(volume : float) -> void:
	_changeVolume(volume, "Sound Effects")
	
func _changeVolume(volume : float, bus : String) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index(bus), volume)
	print(bus, " Volume: ", AudioServer.get_bus_volume_linear(AudioServer.get_bus_index(bus)))
	
