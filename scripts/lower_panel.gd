extends Control
""" Подузел интерфейса поля для ввода номера кабинета """

@onready var TEXT_LINE = $HBoxContainer/Search
@onready var SEARCH_BUTTON = $HBoxContainer/Button_search

func _ready():
	SEARCH_BUTTON.pressed.connect(search_class_function)
	TEXT_LINE.text_submitted.connect(search_class_function)
	TEXT_LINE.focus_entered.connect(text_line_focus_entered)

func search_class_function(_data = null): # _data нужна только как заполнитель, так как сигнал text_submitted нативно передает аргумент
	#функция имеет две точки вхождения: после ввода (Enter или search button)
	
	TEXT_LINE.release_focus()
	Events.keyboard_visibility_changed.emit(0)
	
	if int(TEXT_LINE.text) != null: # обработка TEXT != NULL
		var current_class_out_text: int = int(TEXT_LINE.text)
		if Global.classes_floors.has(current_class_out_text): # обработка TEXT=REAL CLASS (default)
			Global.change_data(current_class_out_text)
			TEXT_LINE.clear()
			TEXT_LINE.placeholder_text = "Каб. № %s выделен" %current_class_out_text
		else: #обработка TEXT != REAL CLASS
			blink_text_line()
			TEXT_LINE.clear()
			TEXT_LINE.placeholder_text = "Каб. № %s не найден!" %current_class_out_text
	elif TEXT_LINE.text != "": #обработка TEXT != value
		blink_text_line()
		TEXT_LINE.clear()
		TEXT_LINE.placeholder_text = "Недопустимые символы!"

func blink_text_line(blick_color : Color = Color.RED):
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	tween.tween_property(TEXT_LINE, "modulate", blick_color, 0.5)
	tween.tween_property(TEXT_LINE, "modulate", Color.WHITE, 0.2)

func text_line_focus_entered():
	Events.keyboard_visibility_changed.emit(1)
