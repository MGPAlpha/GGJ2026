extends Node

@export var master_volume : float
@export var music_volume : float
@export var sound_effect_volume : float

var music_player : AudioStreamPlayer
var music_main_menu : AudioStream
var music_level : AudioStream

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music_main_menu = load("res://assets/music/Trouble Makers (Loopable).wav")
	music_level = load("res://assets/music/crow theme draft loopable.mp3")
	
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Music"
	add_child(music_player)
	
	_startMainMenuMusic()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _startMainMenuMusic() -> void:
	music_player.stop()
	music_player.stream = music_main_menu
	music_player.play()
	
func startLevelMusic() -> void:
	music_player.stop()
	music_player.stream = music_level
	music_player.play()
