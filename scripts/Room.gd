extends Node2D

signal room_over

func _ready():
#	get_node('Player').position.x = position.x + 100
	pass

func _on_EnemyManager_no_enemy():
	if $'../'.current_room == $'../'.num_rooms - 1:
		emit_signal('room_over')
	else:
		$Exit/CollisionShape2D.disabled = false

func _on_Exit_body_entered(body):
	emit_signal('room_over')
	queue_free()


