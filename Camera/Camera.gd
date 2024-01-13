extends Camera2D
class_name Camera


var player_character: PlayerCharacter = null


func _process(delta):
	if player_character == null:
		player_character = get_node_or_null('../PlayerCharacter')
		if player_character == null: return
	
	position = player_character.position

	return

