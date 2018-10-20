extends RigidBody2D

signal hit
signal dead
export (int) var speed = 200
export (int) var jump_height = 300
var active = false
var walking = false
var activeAnimation = 'idle'
var hp = 100

func _ready():
	set_mode(MODE_CHARACTER)
	$Feet.add_exception(self)
	$AnimatedSprite.play()

func _process(delta):
	var velocity = Vector2()
	
	if active:
		if $Feet.is_colliding():
			if Input.is_action_pressed('ui_up'):
				set_axis_velocity(Vector2(0, -jump_height))
		
		if Input.is_action_pressed('ui_right'):
			velocity.x += speed
			$PunchHand.position.x = 50
		if Input.is_action_pressed('ui_left'):
			velocity.x -= speed
			$PunchHand.position.x = -50
		if Input.is_action_pressed('punch') and activeAnimation != 'punch':
			punch()
		
		if velocity.length() > 0:
			$AnimatedSprite.animation = 'walk'
			$AnimatedSprite.flip_h = linear_velocity.x < 0
		else:
			$AnimatedSprite.animation = activeAnimation
	
	if hp <= 0:
		emit_signal('dead')
	
	set_axis_velocity(velocity)

func punch():
	activeAnimation = 'punch'
	$PunchHand/CollisionShape2D.disabled = false
	$PunchTimer.start()

func _on_PunchTimer_timeout():
	$PunchTimer.stop()
	$AudioStreamPlayer.stop()
	activeAnimation = 'idle'
	$PunchHand/CollisionShape2D.disabled = true

func punch_hit(body):
	if body.get_parent().name == 'EnemyManager':
		$AudioStreamPlayer.play()
		var direction = body.position.x - self.position.x
		var punchForce = Vector2(direction, -100).normalized() * 200
		body.set_axis_velocity(punchForce)
		body.hp -= 10

