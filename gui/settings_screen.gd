class_name SettingsScreen extends Control

signal back_intended

@onready var ui_scale_slider: HSlider = %UIScaleSlider
@onready var back_button: Button = %BackButton

var window: Window


func _ready() -> void:
	window = get_window()

	ui_scale_slider.value = window.content_scale_factor
	ui_scale_slider.value_changed.connect(_on_ui_scale_changed)
	back_button.pressed.connect(back_intended.emit)


func _on_ui_scale_changed(value: float) -> void:
	window.content_scale_factor = value
