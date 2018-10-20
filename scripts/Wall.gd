extends StaticBody2D

export (int) var height
export (int) var width

func _ready():
	$CollisionShape2D.get_shape().set_extents(Vector2(width/2, height/2))

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
