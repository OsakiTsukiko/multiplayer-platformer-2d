extends Node2D

var player_shell_scene: Resource = load("res://src/player/PlayerShell.tscn")
var player_scene: Resource = load("res://src/player/Player.tscn")

onready var spawn_array: Array = [
	$Spawns/Pos1,
	$Spawns/Pos2,
	$Spawns/Pos3,
	$Spawns/Pos4,
	$Spawns/Pos5,
	$Spawns/Pos6,
]

var player_nodes: Array = []

func _ready():
	Gamestate.connect("player_tick_signal", self, "_player_tick_signal")
	for i in range(0, Gamestate.player_list.size()):
		var player = Gamestate.player_list[i]
		var player_node: Node2D = player_scene.instance()
		player_node.set_network_master(player.peer_id)
		player_node.position = spawn_array[i % 6].position
		player_nodes.append(player_node)
		add_child(player_node)

func _player_tick_signal(i: int, pos: Vector2):
	player_nodes[i].position = pos
