class_name RaceSelectionScreen extends Control

signal race_selection_intended(race: Race)
signal cancel_intended

@export var races: Races

@onready var _race_options_list: OptionButton = %RaceOptionsContainer
@onready var _race_portrait: TextureRect = %RacePortraitTextureRect
@onready var _race_description: Label = %RaceDescriptionLabel
@onready var _cancel_button: Button = %CancelButton
@onready var _select_race_button: Button = %SelectRaceButton

var _selected_race: Race


func _ready() -> void:
	for race: Race in races.list:
		_race_options_list.add_item(race.label)

	_race_options_list.item_selected.connect(_on_race_toggled)
	_cancel_button.pressed.connect(cancel_intended.emit)
	_select_race_button.pressed.connect(_on_select_race)

	_on_race_toggled(0)


func _on_race_toggled(index: int) -> void:
	var race: Race = races.list[index]
	_select_race_button.disabled = false
	_race_portrait.texture = race.portrait
	_race_description.text = race.description
	_selected_race = race


func _on_select_race() -> void:
	race_selection_intended.emit(_selected_race)
