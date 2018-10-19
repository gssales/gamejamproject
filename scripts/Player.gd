extends RigidBody2D

export (int) var speed = 20
export (int) var jump_height = 300

func _ready():
	set_mode(MODE_CHARACTER)
	$Feet.add_exception(self)

func _process(delta):
	if $Feet.is_colliding():
		if Input.is_action_pressed('ui_up'):
			set_axis_velocity(Vector2(0, -jump_height))
	
	if Input.is_action_pressed('ui_right'):
		set_axis_velocity(Vector2(speed, 0))
	
	if Input.is_action_pressed('ui_left'):
		set_axis_velocity(Vector2(-speed, 0))