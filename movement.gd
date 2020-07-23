extends Camera

onready var map2 = preload("res://map.gd").new()
var dir = {
	"N": [ Vector3(0, 0, -1), Vector3(0, 0, 1), Vector3(-1, 0, 0), Vector3(1, 0, 0) ],
	"S": [ Vector3(0, 0, 1), Vector3(0, 0, -1), Vector3(1, 0, 0), Vector3(-1, 0, 0) ],
	"W": [ Vector3(-1, 0, 0), Vector3(1, 0, 0), Vector3(0, 0, 1), Vector3(0, 0, -1) ],
	"E": [ Vector3(1, 0, 0), Vector3(-1, 0, 0), Vector3(0, 0, -1), Vector3(0, 0, 1) ]}
var direct = ["N", "S", "W", "E"]
var move = "stop"
var step = 0
var pos = Vector3(5, 1, 5)
var rotL = 0
var rot = 0
var id = {87:0, 83:1, 65:2, 68:3}

func step_mov(key):
	if(Input.is_key_pressed(key) 
	and map2.Map1[round(pos.z+dir[direct[0]][id[key]].z)][round(pos.x+dir[direct[0]][id[key]].x)] < 1
	and move == "stop") or move == direct[id[key]]:
		move = direct[id[key]]
		step += 1
		pos += 0.1*dir[direct[0]][id[key]]
		if step == 10:
			move = "stop"
			step = 0
			pos = Vector3(round(pos.x), 1, round(pos.z))
		self.set_translation(Vector3(pos.x*2+1, 1, pos.z*2+1))

func rot():
	if (Input.is_key_pressed(KEY_Q)) and step == 0 and rot == 0 or rotL != 0:
		if rotL == 0:
			direct.push_back(direct[0])
			direct.pop_front()
		rotL += 1; if rotL == 100: rotL = 0
		self.rotate(Vector3(0, 1, 0), -0.0157)
	if (Input.is_key_pressed(KEY_E)) and step == 0 and rotL == 0 or rot != 0:
		if rot == 0:
			direct.push_front(direct[3])
			direct.pop_back()
		rot += 1; if rot == 100: rot = 0
		self.rotate(Vector3(0, 1, 0), 0.0157)

func _ready():
	self.set_translation(Vector3(pos.x*2+1, 1, pos.x*2+1))
	set_process(true)

func _process(delta):
	step_mov(KEY_W)
	step_mov(KEY_A)
	step_mov(KEY_S)
	step_mov(KEY_D)
	rot()
