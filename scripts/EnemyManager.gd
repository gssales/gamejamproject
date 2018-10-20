extends Node

signal no_enemy
export (int) var numEnemies
export (PackedScene) var Enemy
export (float) var waitTime
export (int) var enemySpeed
var spawnedEnemies = 0
var deadEnemies = 0

func _ready():
	$SpawnTimer.wait_time = waitTime

func _process(delta):
	if spawnedEnemies >= numEnemies:
		$SpawnTimer.stop()
	if deadEnemies >= numEnemies:
		emit_signal('no_enemy')

func _on_StartTimer_timeout():
	$SpawnTimer.start()

func _on_SpawnTimer_timeout():
	var enemy = Enemy.instance()
	add_child(enemy)
	enemy.speed = enemySpeed
	enemy.mass = 9
	enemy.gravity_scale = 5
	if randi() % 2 == 0:
		enemy.position = $LeftSpawn.position
	else:
		enemy.position = $RightSpawn.position
	enemy.connect('dead', self, '_on_Enemy_dead')
	spawnedEnemies += 1

func _on_Enemy_dead(enemy):
	deadEnemies += 1
	enemy.queue_free()