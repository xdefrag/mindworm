extends Node

onready var map2 = preload("res://map.gd").new()

var FCnode = load("res://floor.tscn")
var WallNode = load("res://wall.tscn")
var wall = []
var fc = []
var dir = {"N": Vector2(0, -1), "S": Vector2(0, 1), "W": Vector2(-1, 0), "E": Vector2(1, 0)}
var d = ["N", "S", "W", "E"]
var pos = Vector3(5, 1, 5)
var rot = 0

func _ready():
	get_node("Camera").set_translation(Vector3(pos.x*2+1, 1, pos.x*2+1))
	set_process(true)
	for x in range(map2.Map1.size()):
		for y in range(map2.Map1[0].size()):
			if map2.Map1[y][x] == 0:
				fc.append(FCnode.instance())
				add_child(fc[fc.size()-1])
				fc[fc.size()-1].set_translation(Vector3(x*2+1, 0, y*2+1))
			if map2.Map1[y][x] == 1:
				for n in d:
					if map2.Map1[clamp(y+dir[n].y, 0, 7)][clamp(x+dir[n].x, 0, 7)] == 0:
						wall.append(WallNode.instance())
						add_child(wall[wall.size()-1])
						if n == "N":
							wall[wall.size()-1].set_translation(Vector3(x*2+1, 1, y*2))
							wall[wall.size()-1].rotate(Vector3(0, 1, 0), 3.14)
						if n == "S":
							wall[wall.size()-1].set_translation(Vector3(x*2+1, 1, y*2+2))
						if n == "W":
							wall[wall.size()-1].set_translation(Vector3(x*2, 1, y*2+1))
							wall[wall.size()-1].rotate(Vector3(0, 1, 0), 1.57 + 3.14)
						if n == "E":
							wall[wall.size()-1].set_translation(Vector3(x*2+2, 1, y*2+1))
							wall[wall.size()-1].rotate(Vector3(0, 1, 0), 1.57)

func _process(_delta):
	rot += 1; if rot == 100: rot = 0
	get_node("Camera").rotate(Vector3(0, 1, 0), -0.0157)
