extends Node
""" Глобальный скрипт с сигналами """

#region СИГНАЛЫ ЯДРА
signal floor_changed()
signal class_changed()
signal settings_changed()
#endregion

#region СИГНАЛЫ UI
signal keyboard_visibility_changed(state: bool)
#endregion
