extends Node
""" Глобальный скрипт для настроек и визуальных параметров программы """

var floors_colors = {
	1: Color.CYAN, # green_blue
	2: Color.CORAL, # orange
	3: Color("ffd94f"), # yellow
	4: Color.CORNFLOWER_BLUE # light_blue
}

var parameters = {
	"floors_colors" : floors_colors,
	"selection_color": Color(0.5, 1.0, 0),
}

func get_value(key, key1 = null):
	if key1 == null: return parameters[key]
	return parameters[key][key1]

func set_value(value, key, key1 = null):
	if key1 == null:
		parameters[(key)] = value
	else:
		parameters[(key)][key1] = value
	Events.settings_changed.emit()
#
#func reset():
	#parameters = {
	#"Selection_color": Color(0.5, 1.0, 0)}
	#Events.settings_changed.emit()
