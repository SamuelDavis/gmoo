class_name MainMenuScreen extends Control

signal new_game_intended
signal quit_intended

@onready var _new_game_button: Button = %NewGameButton
@onready var _quit_button: Button = %QuitGameButton


func _ready() -> void:
	_new_game_button.pressed.connect(new_game_intended.emit)
	_quit_button.pressed.connect(quit_intended.emit)
