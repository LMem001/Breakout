extends CharacterBody2D
var initial_position = Vector2()

func _physics_process(delta):
	_move_direction()
	move_and_slide()

func _ready():
	initial_position = position
	
func _move_direction():
	var direction = Input.get_vector("move_left", "move_right", "", "")
	velocity = direction * 600
	
func reset_player():
	position = initial_position
