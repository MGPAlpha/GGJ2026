extends Node

@export var StartButton : Button

func _ready():
	$"VBoxContainer Buttons/StartButton".pressed.connect(_on_start_pressed)
	$"VBoxContainer Buttons/OptionsButton".pressed.connect(_on_options_pressed)
	$"VBoxContainer Buttons/QuitButton".pressed.connect(_on_quit_pressed)
	$"VBoxContainer Slider/BackButton".pressed.connect(_on_back_pressed)
	$"VBoxContainerCredits/BackButton".pressed.connect(_on_back_pressed)
	$"VBoxContainer Buttons/CreditsButton".pressed.connect(_on_credits_pressed)
#	Sets up the initial focus
	$"VBoxContainer Buttons/StartButton".grab_focus()

func _on_start_pressed():
#	Do some method to actually start the game. As of now, this does nothing
	get_tree()
	

func _on_options_pressed():
#	The volume slider doesn't actually work right now.
	$"VBoxContainer Slider".visible = true
	$"VBoxContainer Slider/VolumeHSlider".grab_focus()
	$"VBoxContainer Buttons".visible = false

func _on_credits_pressed():
	$VBoxContainerCredits.visible = true
	$"VBoxContainer Buttons".visible = false
	$VBoxContainerCredits/BackButton.grab_focus()

func _on_back_pressed():
	$"VBoxContainer Slider".visible = false
	$VBoxContainerCredits.visible = false
	$"VBoxContainer Buttons".visible = true
	$"VBoxContainer Buttons/StartButton".grab_focus()

func _on_quit_pressed():
	get_tree().quit()
