extends Node
""" Глобальный скрипт с переменными, ссылками и функциями ядра программы """

#region КОНСТАНТЫ И ССЫЛКИ
@onready var IS_MOBILE: bool = OS.has_feature("mobile")
@onready var UI: Node = get_node("/root/Main_scene/HUD/UI")
#endregion

#region КАБИНЕТЫ (class) И ЭТАЖИ (floor)
var classes_floors = {
	101: 1,
	102: 1,
	103: 1,
	104: 1,
	105: 1,
	106: 1,
	107: 1,
	109: 1,
	110: 1,
	115: 1,
	116: 1,
	117: 1,
	202: 1,
	1171: 2,
	118: 2,
	119: 2,
	120: 2,
	121: 2,
	122: 2,
	123: 2,
	124: 2,
	125: 2,
	126: 2,
	127: 2,
	128: 2,
	129: 2,
	131: 2,
	132: 2,
	133: 2,
	134: 2,
	135: 2,
	136: 2,
	137: 2,
	138: 2,
	139: 2,
	140: 2,
	211: 2,
	212: 2,
	213: 2,
	214: 2,
	215: 2,
	216: 2,
	141: 3,
	142: 3,
	143: 3,
	144: 3,
	145: 3,
	146: 3,
	147: 3,
	148: 3,
	149: 3,
	150: 3,
	151: 3,
	152: 3,
	153: 3,
	154: 3,
	156: 3,
	157: 3,
	158: 3,
	159: 3,
	160: 3,
	161: 3,
	162: 3,
	163: 3,
	164: 4,
	165: 4,
	166: 4,
	167: 4,
	168: 4,
	169: 4,
	170: 4,
	171: 4,
	172: 4,
	173: 4,
	174: 4,
	175: 4,
	176: 4,
	177: 4,
	178: 4,
	179: 4,
	180: 4,
	181: 4,
	182: 4,
	183: 4,
	184: 4,
	185: 4,
}

var current_class: int# = 0
var old_class: int# = 1
var current_floor: int# = 1
var old_floor: int# = 1

func class2floor(num_class: int):
	return classes_floors[(num_class)]

func change_data(aclass: int):
	if current_floor != class2floor(aclass):
		change_floor(class2floor(aclass))
	change_class(aclass)

func change_class(aclass: int):
	old_class=current_class
	current_class = aclass
	Events.class_changed.emit()

func change_floor(afloor: int):
	old_floor=current_floor
	current_floor=afloor
	Events.floor_changed.emit()
#endregion
