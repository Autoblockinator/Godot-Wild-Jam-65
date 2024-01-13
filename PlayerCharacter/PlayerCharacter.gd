extends CharacterBody2D
class_name PlayerCharacter


const SPEED = 300.0
const ACCELERATION = 100.0
const DECELERATION = 100.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const JUMP_VELOCITY = -400.0
var coyote_time: bool = true
var movement_input: Dictionary = {
	'up': false,
	'down': false,
	'left': false,
	'right': false,
}


func jump(): return


func _physics_process(delta):
	if !is_on_floor(): velocity.y += gravity * delta

	var target_velocity = 0.0
	if movement_input.right: target_velocity += SPEED
	if movement_input.left:  target_velocity -= SPEED
	
	var accel = 0.0
	if velocity.x != target_velocity:
		if velocity.x < target_velocity:
			accel = minf(
				ACCELERATION * delta,
				(target_velocity - velocity.x) * delta
			)
		elif velocity.x > target_velocity:
			accel = maxf(
				-accel * delta,
				(target_velocity - velocity.x) * delta
			)
	
	velocity.x += accel

	move_and_slide()
	return


func _unhandled_input(event):
	if !(event is InputEventKey): return
	var inputs: Dictionary = $/root/Main/Settings.input
	
	if event.keycode in inputs.jump: jump()
	
	if event.keycode in inputs.left: movement_input.left = event.is_pressed()
	if event.keycode in inputs.right: movement_input.right = event.is_pressed()
	return

