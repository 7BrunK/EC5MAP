extends MarginContainer
""" Узел для визуальной работы с этажами и кабинетами """

var FLOORS_SCENES = {
	1: preload("res://scenes/Floors/floor_1.tscn"),
	2: preload("res://scenes/Floors/floor_2.tscn"),
	3: preload("res://scenes/Floors/floor_3.tscn"),
	4: preload("res://scenes/Floors/floor_4.tscn")
}

@onready var CAMERA: Node = get_node("Camera2D")
@onready var FLOORS_GROUP: Node = get_node("Floors")

func _ready():
	Events.floor_changed.connect(update_floor)
	Events.class_changed.connect(select_class)

func select_class():
	var old_class_node = FLOORS_GROUP.get_child(0).get_node("Classes/{class}".format({"class":str(Global.old_class)}))
	var current_class_node = FLOORS_GROUP.get_child(0).get_node("Classes/{class}".format({"class":str(Global.current_class)}))
	if old_class_node != null:
		old_class_node.self_modulate = Color.WHITE
	current_class_node.self_modulate = Settings.get_value("selection_color")
	CAMERA.move2node(current_class_node)

func update_floor():
	var floor = Global.current_floor
	if FLOORS_GROUP.get_child_count() >= 1:
		FLOORS_GROUP.get_child(0).free()
	FLOORS_GROUP.add_child(FLOORS_SCENES[floor].instantiate())
