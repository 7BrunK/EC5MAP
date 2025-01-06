extends MarginContainer
""" Корневой узел интерфейса """

@onready var KEYBOARD: Node = $VBoxContainer/Keyboard
@onready var LOWER_PANEL: Node = $VBoxContainer/Down/Lower_panel
@onready var SETTINGS_MENU: Node = $Settings_Menu

@onready var FLOORS_ICON: Node = $VBoxContainer/Up/Floor
@onready var FLOORS_LABEL: Node = $VBoxContainer/Up/Number
@onready var BACKGROUND_IMAGE: Node = get_tree().get_root().get_node("Main_scene").get_child(0).get_child(0)

func _ready():
	Events.floor_changed.connect(update_visualization_floor)

func update_visualization_floor(): # обновление отображения номера этажа и цвета изображения в верхней панели
	var floor = Global.current_floor
	FLOORS_LABEL.text = str(floor)
	FLOORS_ICON.self_modulate = Settings.get_value("floors_colors", floor)
	BACKGROUND_IMAGE.self_modulate = Settings.get_value("floors_colors", floor)

func _on_settings_button_pressed():
	SETTINGS_MENU.show()

func keyboard_controller(button_name):
	match button_name:
		"BACKSPACE":
			LOWER_PANEL.TEXT_LINE.text = LOWER_PANEL.TEXT_LINE.text.substr(0, LOWER_PANEL.TEXT_LINE.text.length() - 1)
		"HIDE":
			KEYBOARD.hide()
		_: #else в поле добавляются цифры
			LOWER_PANEL.TEXT_LINE.text += button_name
