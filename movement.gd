extends Camera

enum {
	STOP,
	MOVING
}

var state: int = STOP

const step: int = 50 # increase for faster rotation

var start_position: Vector3 = Vector3(11, 1, 11) # where it come from??

var current_rotation: float = 0
var current_rotation_step: float = 0

var current_translate: float = 0
var current_translate_step: float = 0

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
			current_translate = -2
		elif Input.is_action_pressed("move_back"):
			current_translate = 2

		if current_rotation != 0 or current_translate != 0:
			state = MOVING
	MOVING:
		if current_rotation != 0 and current_rotation_step == 0:
			current_rotation_step = current_rotation / step

		if current_rotation > 0 and current_rotation_step > 0 or current_rotation < 0 and current_rotation_step < 0:
			rotate_object_local(Vector3(0, 1, 0), current_rotation_step)
			current_rotation -= current_rotation_step
		else:
			current_rotation = 0
			current_rotation_step = 0

		if current_translate != 0 and current_translate_step == 0:
			current_translate_step = current_translate / step

		if current_translate > 0 and current_translate_step > 0 or current_translate < 0 and current_translate_step < 0:
			translate_object_local(Vector3(0, 0, current_translate_step))
			current_translate -= current_translate_step
		else:
			current_translate = 0
			current_translate_step = 0

		if current_rotation == 0 and current_translate == 0:
			state = STOP
