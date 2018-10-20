extends RigidBody2D

signal dead
export (int) var speed = 200
var hp = 30
var walking = true
var shoot = true
var activeAnimation = 'idle'
onready var player = get_node('../../Player')

func _ready():
	set_mode(MODE_CHARACTER)
	$Feet.add_exception(self)
	$AnimatedSprite.play()
	$BulletSeed.hide()

func _process(delta):
	var velocity = Vector2()
	
	if $Feet.is_colliding():
		if player.position.distance_to(self.position) <= 500 and shoot:
			punch()
		elif player.position.distance_to(self.position) > 500:
			if player.position.x < self.position.x:
				velocity.x -= speed
				$PunchHand.position.x = -90
				$BulletSeed.position.x = -75
			elif player.position.x > self.position.x:
				velocity.x += speed
				$PunchHand.position.x = 90
				$BulletSeed.position.x = 75
	
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
	shoot = false
	activeAnimation = 'punch'
	$PunchTimer.start()
	var direction = 1
	if $AnimatedSprite.flip_h:
		direction = -1
	$BulletSeed.direction = Vector2(direction, 0)
	$BulletSeed.shoot()

func _on_PunchTimer_timeout():
	$PunchTimer.stop()
	$PunchDelayTimer.start()
	activeAnimation = 'idle'
	
func punch_hit(body):
	if body.name == 'Player':
		var direction = body.position.x - self.position.x
		var punchForce = Vector2(direction, -100).normalized() * 200
		body.set_axis_velocity(punchForce)
		body.hp -= 10
		body.emit_signal('hit')

func _on_PunchDelayTimer_timeout():
	$PunchDelayTimer.stop()
	shoot = true
	$BulletSeed.position = position
