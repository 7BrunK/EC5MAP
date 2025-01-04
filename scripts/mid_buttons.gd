extends VBoxContainer
""" Подузел интерфейса кнопок для смены этажа """

func _ready() -> void:
	for button in get_children():
		button.pressed.connect(floor_button_pressed.bind(button))

func floor_button_pressed(button):
	Global.change_floor(int(str(button.name)))
