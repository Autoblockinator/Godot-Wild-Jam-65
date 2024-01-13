extends CharacterBody2D
class_name PlayerCharacter


@onready var input: InputManager = get_node_or_null('/root/Main/Input')


const SPEED = 300.0
const ACCELERATION = 100.0
const TURNING_BOOST = 4.0
const STOPPING_SPEED = 50.0
const AIR_STOPPING_SPEED = 0.0
const GRAVITY = 981
const JUMP_POWER = -200.0
const MAX_JUMP_HOLD = 1.0
var can_jump: bool = true
var gravity_mod: float = 1.0
var gravity_tween: Tween = null


func _ready():
	input.connect('jump_pressed', jump_pressed)
	input.connect('jump_released', jump_released)
	return


func _process(delta):
	print(gravity_mod)
	return


func jump_pressed():
	if !can_jump: return
	can_jump = false
	velocity.y = JUMP_POWER
	gravity_mod = 0.0
	gravity_tween = get_tree().create_tween()
	gravity_tween.tween_property(self, 'gravity_mod', 1.0, MAX_JUMP_HOLD)
	return

func jump_released():
	if gravity_tween != null: gravity_tween.stop()
	gravity_mod = 1.0
	return


func _physics_process(delta):
	if is_on_floor():
		if !input.jump_down(): can_jump = true
	else: velocity.y += GRAVITY * gravity_mod * delta

	var target_velocity = input.move_input.x * SPEED
	
	var accel = 0.0# ACCELERATION if target_velocity != 0.0 else STOPPING_SPEED
	if target_velocity != 0.0: accel = ACCELERATION
	else:
		if is_on_floor(): accel = STOPPING_SPEED
		else: accel = AIR_STOPPING_SPEED
	accel *= delta
	accel *= 1.0 if target_velocity - velocity.x > 0 else -1.0
	if (velocity.x >= 0.0) != (target_velocity >= 0.0): accel *= TURNING_BOOST
	
	if abs(accel) < abs(abs(target_velocity) - abs(velocity.x)): velocity.x += accel
	else: velocity.x = target_velocity
	
	move_and_slide()
	return

