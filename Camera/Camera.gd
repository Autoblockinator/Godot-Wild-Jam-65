extends Camera2D
class_name Camera


var stack: Array[ViewTarget] = []
func push(target: ViewTarget): stack.append(target)
func pop(target):
	if target is ViewTarget: stack.erase(target)
	else: stack.remove_at(target)
	return


func _process(delta):
	var weight = 0.0
	var new_pos = position
	var new_rot = rotation
	var new_zoom = zoom.x

	# Blend View Target Properties
	for vt in stack:
		if !(vt.blend_weight > 0.0): continue
		var blend = 1.0
		if weight > 0: blend = 1 / (1 + exp(-1 * (vt.blend_weight - weight)))
		weight += vt.blend_weight

		# Position
		var vt_pos = position + (
			position.direction_to(vt.position)
				*
			vt.follow_speed
				*
			delta
		)
		if vt.speed_curve != null:
			vt_pos *= vt.speed_curve.sample(
				clamp(
					position.distance_to(vt.position)
						/
					vt.max_follow_distance,
					0.0, 1.0
				)
			)
		vt_pos = vt_pos.limit_length(position.distance_to(vt.position))
		new_pos = new_pos.lerp(vt_pos, blend)

		# Rotation
		new_rot = lerp_angle(new_rot, vt.rotation, blend)

		# Zoom
		new_zoom = lerpf(new_zoom, vt.zoom, blend)
	
	position = new_pos
	rotation = new_rot
	zoom = Vector2.ONE * new_zoom
	return

