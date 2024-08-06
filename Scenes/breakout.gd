extends Node2D

@export var brick_scene : PackedScene  # Reference to the Brick scene
@export var rows : int = 4  # Number of rows
@export var columns : int = 8  # Number of columns
@export var brick_spacing : Vector2 = Vector2(200, 60)  # Spacing between bricks
@export var start_position : Vector2 = Vector2(80, 100)  # Starting position for the grid

func _ready():
	generate_bricks()
	
func generate_bricks():
	for row in range(rows):
		for col in range(columns):
			var brick_instance = brick_scene.instantiate()  # Create an instance of the Brick scene
			var brick_position = start_position + Vector2(col * brick_spacing.x, row * brick_spacing.y)
			brick_instance.position = brick_position  # Set the position of the brick
			add_child(brick_instance)  # Add the brick instance to the scene

func _on_pit_area_entered(area):
	%ResetTimer.start()

func _on_reset_timer_timeout():
	%Ball.decrease_speed()
	%Ball.reset_ball()
