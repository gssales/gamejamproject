extends Node


func _ready():
	
	pass

func _process(delta):
	if Input.is_action_pressed('ui_cancel'):
		get_tree().quit()
	
	if Input.is_action_pressed('reload'):
		get_tree().reload_current_scene()
