extends Area2D

var speed = 500
var direction = Vector2()
var shooting = false

func _ready():
	hide()

func _process(delta):
	if shooting:
		var velocity = direction * speed
		position.x += velocity.x * delta
		position.y += velocity.y * delta
		
func shoot():
	show()
	shooting = true
	$CollisionShape2D.disabled = false

func _on_BulletSeed_body_entered(body):
	hide()
	shooting = false
	position = get_parent().position
	$CollisionShape2D.disabled = true
	if body.name == "Player":
		print('jogador atingido')
		
