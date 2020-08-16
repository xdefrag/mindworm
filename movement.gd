extends KinematicBody

enum {
	STOP,
	MOVING
}

var state: int = STOP

const step: int = 50 # increase for faster rotation

var start_position: Vector3 = Vector3(0, 0, 0) # where it come from??

var current_rotation: float = 0
var current_rotation_step: float = 0

var current_move_direction: Vector3 = Vector3.ZERO
var current_move_step: Vector3 = Vector3.ZERO

func _ready():
	self.set_translation(start_position)
	set_process(true)

func _process(delta: float): match state:
	STOP:
		if Input.is_action_pressed("turn_left"):
			current_rotation = PI / 2
		elif Input.is_action_pressed("turn_right"):
			current_rotation = - PI / 2
		elif Input.is_action_pressed("move_forward"):
			current_move_direction -= self.get_global_transform().basis.z
		elif Input.is_action_pressed("move_back"):
			current_move_direction += self.get_global_transform().basis.z

		if current_rotation != 0 or current_move_direction != Vector3.ZERO:
			state = MOVING
	MOVING:
		if current_rotation != 0 and current_rotation_step == 0:
			current_rotation_step = current_rotation / step

		if current_rotation > 0 and current_rotation_step > 0 or current_rotation < 0 and current_rotation_step < 0:
			rotate_y(current_rotation_step)
			current_rotation -= current_rotation_step
		else:
			current_rotation = 0
			current_rotation_step = 0

		if current_move_direction != Vector3.ZERO and current_move_step == Vector3.ZERO:
			current_move_step = current_move_direction.normalized() * delta

		if current_move_direction > Vector3.ZERO and current_move_step > Vector3.ZERO or current_move_direction < Vector3.ZERO and current_move_step < Vector3.ZERO:
			move_and_collide(current_move_step * 2)
			current_move_direction -= current_move_step
		else:
			current_move_direction = Vector3.ZERO
			current_move_step = Vector3.ZERO

		if current_rotation == 0 and current_move_direction == Vector3.ZERO:
			state = STOP
