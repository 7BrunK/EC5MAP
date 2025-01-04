extends Control
""" Корневой узел всей сцены """

@export var start_floor: int = 1

func _ready() -> void:
	Global.change_floor(start_floor) # начальный этаж
