extends Area2D

@export var Player : NodePath  # Path to the paddle node
var paddle_node : Node2D
var ball_anchor : Node2D
var velocity = Vector2(0, 0)
var body_coll
var x_direction = 230
var speed = 200
var lastHitPlayer
var is_attached : bool = true # attach ball to player
var start_offset : Vector2 = Vector2(0, -30) 

func _physics_process(delta):
	# Move
	position += velocity * delta

func _ready():
	paddle_node = get_node("/root/Breakout/Player")  # Get the paddle node
	ball_anchor = paddle_node.get_node("BallAnchor")  # Get the BallAnchor node
	set_process_unhandled_input(true)

func _process(delta):
	# Move the ball if the vector is not 0
	if is_attached:
		# Position the ball at the BallAnchor position
		position = ball_anchor.global_position + start_offset
	if velocity != Vector2(0, 0):
		position += velocity * delta

func _unhandled_input(event):
	# Verifica se il tasto "start_game" è premuto e la velocità è zero
	if event.is_action_pressed("start_game") and is_attached:
		start_game()

func start_game():
	# set velocity
	is_attached = false  # Detach the ball from the paddle
	velocity = Vector2(x_direction, -230).normalized() * speed
	print("Gioco iniziato con velocità: ", velocity)
	
func reset_ball():
	# Reset Ball
	velocity = Vector2(0, 0)
	is_attached = true

func _on_body_entered(body):
	lastHitPlayer = false
	body_coll = body.name
	%BallSound.play()
	print("Collision with: ", body_coll)
	if body_coll == "WallsSide":
		print("Collision with Side Wall!")
		# Invert ball x direction
		velocity.x = -velocity.x
	elif body_coll == "WallTop":
		print("Collision With top wall !")
		# Invert ball y direction
		velocity.y = -velocity.y
	elif body_coll.contains("@StaticBody2D") or body_coll == "Brick":
		body.queue_free()
		velocity.y = -velocity.y
		speed += 5

# manages the collisions with the different parts of the paddle
func _on_area_entered(area):
	var area_coll = area.name
	var inverty = -velocity.y
	%BallSound.play()
	if !lastHitPlayer:
		print("Collision with: ", area_coll) 
		if area_coll == "CenterArea":
			print("Collision center!")
			# Invert ball x direction
			velocity = Vector2(velocity.x / 3, inverty).normalized() * speed
			lastHitPlayer = true
		elif area_coll == "LeftArea":
			print("Collision left!")
			# Invert ball y direction
			velocity = Vector2(-230, inverty).normalized() * speed
			lastHitPlayer = true
		elif area_coll == "RightArea":
			print("Collision rightl!")
			# Invert ball y direction
			velocity = Vector2(230, inverty).normalized() * speed
			lastHitPlayer = true
