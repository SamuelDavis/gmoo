class_name GameConfigurationScreen extends Control

signal game_configuration_intended(config: GameConfiguration)
signal cancel_intended

@onready var _galaxy_size_option: OptionButton = %GalaxySizeOptionButton
@onready var _difficulty_option: OptionButton = %DifficultyOptionButton
@onready var _opponents_spin_box: SpinBox = %OpponentsSpinBox

@onready var _cancel_button: Button = %CancelButton
@onready var _ok_button: Button = %OkButton


func _ready() -> void:
	_cancel_button.pressed.connect(_on_cancel)
	_ok_button.pressed.connect(_on_ok)

	for key: String in GameConfiguration.GalaxySize.keys():
		_galaxy_size_option.add_item(key.capitalize(), GameConfiguration.GalaxySize[key])

	for key: String in GameConfiguration.Difficulty.keys():
		_difficulty_option.add_item(key.capitalize(), GameConfiguration.Difficulty[key])


func _on_cancel() -> void:
	cancel_intended.emit()


func _on_ok() -> void:
	var configuration: GameConfiguration = GameConfiguration.new()
	configuration.size = _galaxy_size_option.get_selected_id() as GameConfiguration.GalaxySize
	configuration.difficulty = _difficulty_option.get_selected_id() as GameConfiguration.Difficulty
	configuration.opponents = int(_opponents_spin_box.value)
	game_configuration_intended.emit(configuration)
