extends Camera2D
class_name Camera


func _process(delta):
	var player: PlayerCharacter = $'../PlayerCharacter'
	if player == null: return
	
	position.y = player.position.y

	position.x = (
		player.position.x
			+
		clampf(player.velocity.x / 100.0, -1.0, 1.0)
			*
		100.0
	)
	return

