extends Panel
""" Узел клавиатуры для ввода текста """

func _ready():
	Events.keyboard_visibility_changed.connect(change_visibility)
	for button in get_node("MarginContainer/Numpad").get_children():
		button.pressed.connect(Global.UI.keyboard_controller.bind(button.name))

func change_visibility(state: bool): #state {0 = hide, 1 = show}
	if Global.IS_MOBILE:
		visible = state

func click(button_name):
	Global.UI.keyboard_controller(str(button_name))
