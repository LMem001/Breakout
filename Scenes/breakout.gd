extends Node2D

@export var brick_scene : PackedScene  # Reference to the Brick scene
var rows : int = 4  # Number of rows
var columns : int = 8  # Number of columns
var brickNumb : int  # Number of bricks
var brick_spacing : Vector2 = Vector2(200, 60)  # Spacing between bricks
var start_position : Vector2 = Vector2(80, 100)  # Starting position for the grid
var lives = 3

func _ready():
	generate_bricks()
	
func generate_bricks():
	brickNumb = rows * columns
	for row in range(rows):
		for col in range(columns):
			var brick_instance = brick_scene.instantiate()  # Create an instance of the Brick scene
			var brick_position = start_position + Vector2(col * brick_spacing.x, row * brick_spacing.y)
			brick_instance.position = brick_position  # Set the position of the brick
			add_child(brick_instance)  # Add the brick instance to the scene
			
func substractBrick():
	brickNumb -= 1
	if (brickNumb):
		print("You Win")

func _on_pit_area_entered(area):
	lives -= 1
	if(lives > 0):
		%ResetTimer.start()
	else: 
		print("You loose")

func _on_reset_timer_timeout():
	%Ball.decrease_speed()
	%Ball.reset_ball()
