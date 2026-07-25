class_name RaceSelectionScreen extends Control

signal race_selection_intended(race: Race)

@export var races: Races

@onready var _race_options_list: VBoxContainer = %RaceOptionsList
@onready var _race_portrait: TextureRect = %RacePortraitTextureRect
@onready var _race_description: Label = %RaceDescriptionLabel
@onready var _select_race_button: Button = %SelectRaceButton

var _selected_race: Race


func _ready() -> void:
	var button_group: ButtonGroup = ButtonGroup.new()
	for race: Race in races.list:
		var button: CheckBox = CheckBox.new()
		button.button_group = button_group
		button.text = race.label
		button.toggled.connect(_on_race_toggled.bind(race))
		_race_options_list.add_child(button)
		button.button_pressed = _selected_race == null

	_select_race_button.pressed.connect(_on_select_race)


func _on_race_toggled(on: bool, race: Race) -> void:
	if on:
		_select_race_button.disabled = false
		_race_portrait.texture = race.portrait
		_race_description.text = race.description
		_selected_race = race


func _on_select_race() -> void:
	race_selection_intended.emit(_selected_race)
