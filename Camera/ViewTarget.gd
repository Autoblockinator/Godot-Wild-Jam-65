@tool
extends Node2D
class_name ViewTarget


@export var zoom: float = 1.0:
	set(value):
		zoom = value
		if Engine.is_editor_hint(): $DemoCamera.zoom = Vector2.ONE * zoom
		return

@export_group('Camera Following')
@export var max_follow_distance: float = 100.0
@export var follow_speed: float = 1000.0
@export var speed_curve: Curve = null


func _ready(): $DemoCamera.queue_free()

