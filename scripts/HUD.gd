extends CanvasLayer

signal start_game

func _ready():
	get_parent().get_node('Room1/Player').connect('hit', self, 'update_health')
	get_parent().get_node('Room2/Player').connect('hit', self, 'update_health')
	get_parent().get_node('Room3/Player').connect('hit', self, 'update_health')
	$MessageLabel.hide()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func update_health(body):
	$Health.text = str(body.hp)

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func show_game_over():
	$MessageLabel.text = "GAME OVER\nReinicie o Executável"
	$MessageLabel.show()

func _on_StartButton_pressed():
	$StartButton.hide()
	$MessageLabel.hide()
	emit_signal('start_game')

func _on_MessageTimer_timeout():
	$MessageLabel.hide()