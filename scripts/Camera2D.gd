extends Camera2D
""" Узел камеры """

@export var zoom_speed: float = 0.1
@export var pan_speed: float = 1.0
@export var rotation_speed: float = 1.0
@export var tween_speed: float = 0.4

@export var can_pan: bool
@export var can_zoom: bool
@export var can_rotate: bool

var touch_points: Dictionary = {}
var distance0
var distance
var zoom0
var zoom_factor

func _process(delta: float) -> void:
	pass#print(offset)

func _input(event):
	if event is InputEventScreenTouch:
		handle_touch(event)
	elif event is InputEventScreenDrag:
		handle_drag(event)

func handle_touch(event: InputEventScreenTouch):
	if event.pressed:
		touch_points[event.index] = event.position
	else:
		touch_points.erase(event.index)
	if touch_points.size() == 2:
		var touch_point_positions = touch_points.values()
		distance0 = touch_point_positions[0].distance_to(touch_point_positions[1])
		zoom0 = zoom
	elif touch_points.size() < 2:
		distance0 = 0

func handle_drag(event: InputEventScreenDrag):
	touch_points[event.index] = event.position
	if touch_points.size() == 1:
		offset -= event.relative * pan_speed / zoom
	elif touch_points.size() == 2:
		var touch_point_positions = touch_points.values()
		distance = touch_point_positions[0].distance_to(touch_point_positions[1])
		zoom = distance * zoom0 / distance0
		#rotation -= (current_angle - angle0) * rotation_speed
		#angle0 = current_angle
		limit_zoom(zoom)

func limit_zoom(new_zoom):
	if new_zoom.x < 0.5:
		zoom.x = 0.5
	if new_zoom.y < 0.5:
		zoom.y = 0.5
	if new_zoom.x > 5:
		zoom.x = 5
	if new_zoom.y > 5:
		zoom.y = 5

func move2node(target_node: Node, speed_ratio: float = 1.0):
	var tween = create_tween().set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT) # Vector2(target_node.get_global_position() - CAMERA.get_target_position() + Vector2(target_node.size.x/2, target_node.size.y/2))
	if target_node.has_method("get_size"):
		tween.tween_property(self, "offset", target_node.global_position + target_node.size/2, tween_speed / speed_ratio)
	else:
		tween.tween_property(self, "offset", target_node.global_position, tween_speed / speed_ratio)
	tween.tween_property(self, "zoom", Vector2(2.7,2.7), 2 * tween_speed / speed_ratio)

#func get_angle(p1, p2):
	#var delta = p2 - p1
	#return fmod((atan2(delta.y, delta.x) + PI), (2 * PI))
