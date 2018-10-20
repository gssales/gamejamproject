extends Node

var current_room = 0
var num_rooms = 3

func _ready():
	$Room1/Player.active = true
	$Room1/Camera2D.current = true
	$Room1/EnemyManager/StartTimer.start()
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass


func _on_Room1_room_over():
	current_room = 1
	$Room1/Player.active = false
	$Room2/Player.active = true
	$Room1/EnemyManager/StartTimer.stop()
	$Room2/EnemyManager/StartTimer.start()
	$Room1/Camera2D.current = false
	$Room2/Camera2D.current = true

func _on_Room2_room_over():
	current_room = 2
	$Room2/Player.active = false
	$Room3/Player.active = true
	$Room2/EnemyManager/StartTimer.stop()
	$Room3/EnemyManager/StartTimer.start()
	$Room2/Camera2D.current = false
	$Room3/Camera2D.current = true
