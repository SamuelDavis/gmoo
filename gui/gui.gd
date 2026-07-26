class_name GUI extends CanvasLayer

const MAIN_MENU_SCREEN: PackedScene = preload("res://gui/main_menu_screen.tscn")
const GAME_CONFIGURATION_SCREEN: PackedScene = preload("res://gui/game_configuration_screen.tscn")
const RACE_SELECTION_SCREEN: PackedScene = preload("res://gui/race_selection_screen.tscn")
const SETTINGS_SCREEN: PackedScene = preload("res://gui/settings_screen.tscn")

var _current_screen: Node
var _new_game_configuration: GameConfiguration
var _base_width: float = ProjectSettings.get_setting("display/window/size/viewport_width")


func _ready() -> void:
	var window: Window = get_window()
	get_window().content_scale_factor = maxf(1.5, _base_width / maxi(1, window.size.x))
	_to_main_menu()


func _to_main_menu() -> void:
	_new_game_configuration = null
	var next_screen: MainMenuScreen = MAIN_MENU_SCREEN.instantiate()
	next_screen.new_game_intended.connect(_to_game_configuration)
	next_screen.settings_intended.connect(_to_settings_screen)
	next_screen.quit_intended.connect(get_tree().quit)

	_switch_to(next_screen)


func _to_game_configuration() -> void:
	var next_screen: GameConfigurationScreen = GAME_CONFIGURATION_SCREEN.instantiate()
	next_screen.game_configuration_intended.connect(
		func(configuration: GameConfiguration) -> void:
			_new_game_configuration = configuration
			_to_race_selection()
	)
	next_screen.cancel_intended.connect(_to_main_menu)

	_switch_to(next_screen)


func _to_race_selection() -> void:
	var next_screen: RaceSelectionScreen = RACE_SELECTION_SCREEN.instantiate()
	next_screen.race_selection_intended.connect(
		func(race: Race) -> void:
			_new_game_configuration.race = race
			_to_main_game()
	)
	next_screen.cancel_intended.connect(_to_main_menu)

	_switch_to(next_screen)


func _to_main_game() -> void:
	print_debug(
		(
			"size: %s, diff: %s, opps: %s, race: %s"
			% [
				_new_game_configuration.size,
				_new_game_configuration.difficulty,
				_new_game_configuration.opponents,
				_new_game_configuration.race.label,
			]
		)
	)


func _to_settings_screen() -> void:
	var next_screen: SettingsScreen = SETTINGS_SCREEN.instantiate()
	next_screen.back_intended.connect(_to_main_menu)

	_switch_to(next_screen)


func _switch_to(next_screen: Node) -> void:
	if _current_screen:
		remove_child(_current_screen)  # avoid two screens while freeing
		_current_screen.queue_free()
	_current_screen = next_screen
	add_child(_current_screen)
