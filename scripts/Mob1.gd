extends RigidBody2D

signal dead
export (int) var speed = 200
var hp = 30
var follow = true
var punch = true
var activeAnimation = 'idle'
onready var player = get_node('../../Player')

func _ready():
	set_mode(MODE_CHARACTER)
	$Feet.add_exception(self)
	$AnimatedSprite.play()

func _process(delta):
	var velocity = Vector2()
	
	if $Feet.is_colliding():
		var dist = player.position.distance_to(self.position)
		if dist <= 100 and punch:
			punch()
		elif dist > 100:
			if player.position.x < position.x:
				velocity.x -= speed
				$PunchHand.position.x = -90
			elif player.position.x > position.x:
				velocity.x += speed
				$PunchHand.position.x = 90
	
	if velocity.length() > 0:
		$AnimatedSprite.animation = 'walk'
		$AnimatedSprite.flip_h = linear_velocity.x < 0
	else:
		$AnimatedSprite.animation = activeAnimation
	
	if hp <= 0:
		hide()
		emit_signal('dead', self)
	
	set_axis_velocity(velocity)

func punch():
	punch = false
	activeAnimation = 'punch'
	$PunchHand/CollisionShape2D.disabled = false
	$PunchTimer.start()

func _on_PunchTimer_timeout():
	$PunchTimer.stop()
	$PunchDelayTimer.start()
	$AudioStreamPlayer.stop()
	activeAnimation = 'idle'
	$PunchHand/CollisionShape2D.disabled = true
	
func punch_hit(body):
	if body.name == 'Player':
		$AudioStreamPlayer.play()
		var direction = body.position.x - self.position.x
		var punchForce = Vector2(direction, -100).normalized() * 200
		body.set_axis_velocity(punchForce)
		if randi() % 2 == 1:
			body.hp -= 10
			body.emit_signal('hit', body)

func _on_PunchDelayTimer_timeout():
	$PunchDelayTimer.stop()
	punch = true
