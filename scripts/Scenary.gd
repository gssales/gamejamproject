extends Node

export (Texture) var background

func _ready():
	$Background.texture = background

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
