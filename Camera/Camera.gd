extends Camera2D
class_name Camera


const FOLLOW_SPEED: float = 100.0
const FOLLOW_SPEED_CURVE: Curve = preload("res://Camera/FollowSpeedCurve.tres")
const MAX_FOLLOW_DISTANCE: float = 100.0
@onready var player: PlayerCharacter = get_node_or_null('../PlayerCharacter')


func _process(delta):
	if player == null:
		player = get_node_or_null('../PlayerCharacter')
		if player == null: return
	
	var move = (
		position.direction_to(player.position)
			*
		delta
			*
		FOLLOW_SPEED
			*
		FOLLOW_SPEED_CURVE.sample(
			clamp(
				position.distance_to(player.position)
					/
				MAX_FOLLOW_DISTANCE,
				0.0, 1.0
			)
		)
	)

	if move.length() < position.distance_to(player.position):
		position += move
		if position.distance_to(player.position) > MAX_FOLLOW_DISTANCE:
			position = player.position + (
				player.position.direction_to(position)
					*
				MAX_FOLLOW_DISTANCE
			)
	else: position = player.position
	return

