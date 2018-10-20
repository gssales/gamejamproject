extends Node

var current_room = 0
var num_rooms = 3
var life = 100

func _ready():
	randomize()
	$Room1/Player.connect('dead', self, 'game_over')
	$Room2/Player.connect('dead', self, 'game_over')
	$Room3/Player.connect('dead', self, 'game_over')
	$Sprite.hide()
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass


func _on_Room1_room_over():
	current_room = 1
	$Room1/Player.active = false
	$Room2/Player.active = true
	life = $Room1/Player.hp
	$Room2/Player.hp = life
	$Room1/EnemyManager/StartTimer.stop()
	$Room2/EnemyManager/StartTimer.start()
	$Room1/Camera2D.current = false
	$Room2/Camera2D.current = true

func _on_Room2_room_over():
	current_room = 2
	$Room2/Player.active = false
	$Room3/Player.active = true
	life = $Room2/Player.hp
	$Room3/Player.hp = life
	$Room2/EnemyManager/StartTimer.stop()
	$Room3/EnemyManager/StartTimer.start()
	$Room2/Camera2D.current = false
	$Room3/Camera2D.current = true

func game_over():
	if current_room == 0:
		$Room1/Player.active = false
	elif current_room == 1:
		$Room2/Player.active = false
	elif current_room == 2:
		$Room3/Player.active = false
	$HUD.show_game_over()

func win_game():
	$Sprite.show()

func new_game():
	life = 100
	$Room1/Player.position =  Vector2(50,460)
	$Room1/Player.position =  Vector2(1500,460)
	$Room1/Player.position =  Vector2(2950,460)
	
	$Room1/Player.active = true
	$Room1/Player.hp = life
	$Room1/Camera2D.current = true
	$Room1/EnemyManager/StartTimer.start()

func _on_Room3_room_over():
	win_game()
