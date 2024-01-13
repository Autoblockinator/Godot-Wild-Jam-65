extends Node
class_name InputManager


# Jumping
var jump_buttons: Dictionary = {KEY_SPACE: false}
var previous_jump_down: bool = false
func jump_down(): return true in jump_buttons.values()
signal jump_pressed
signal jump_released


# Movement
var move_buttons: Dictionary = {
	'up': {KEY_W: false, KEY_UP: false},
	'down': {KEY_S: false, KEY_DOWN: false},
	'left': {KEY_A: false, KEY_LEFT: false},
	'right': {KEY_D: false, KEY_RIGHT: false},
}
var move_input: Vector2 = Vector2.ZERO
func calc_move_input():
	var new = Vector2.ZERO
	if true in move_buttons.up.values():    new += Vector2.UP
	if true in move_buttons.down.values():  new += Vector2.DOWN
	if true in move_buttons.left.values():  new += Vector2.LEFT
	if true in move_buttons.right.values(): new += Vector2.RIGHT
	move_input = new
	return


# Gather Input
func _unhandled_input(event):
	if event is InputEventKey:
		
		# Jump
		if event.keycode in jump_buttons:
			jump_buttons[event.keycode] = event.pressed
			
			if previous_jump_down != jump_down():
				if event.pressed: emit_signal('jump_pressed')
				else: emit_signal('jump_released')
			
			previous_jump_down = jump_down()
		
		# Move Up
		elif event.keycode in move_buttons.up:
			var calc = move_buttons.up[event.keycode] != event.pressed
			move_buttons.up[event.keycode] = event.pressed
			if calc: calc_move_input()
		
		# Move Down
		elif event.keycode in move_buttons.down:
			var calc = move_buttons.down[event.keycode] != event.pressed
			move_buttons.down[event.keycode] = event.pressed
			if calc: calc_move_input()
		
		# Move Left
		elif event.keycode in move_buttons.left:
			var calc = move_buttons.left[event.keycode] != event.pressed
			move_buttons.left[event.keycode] = event.pressed
			if calc: calc_move_input()
		
		# Move Right
		elif event.keycode in move_buttons.right:
			var calc = move_buttons.right[event.keycode] != event.pressed
			move_buttons.right[event.keycode] = event.pressed
			if calc: calc_move_input()
	return

