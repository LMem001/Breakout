extends Area2D

var velocity = Vector2(0, 0)
var initial_position = Vector2()
var body_coll
var x_direction = 230
var speed = 200
var lastHitPlayer

func _physics_process(delta):
	# Move
	position += velocity * delta

func _ready():
	initial_position = position
	set_process_unhandled_input(true)

func _process(delta):
	# Move the ball if the vector is not 0
	if velocity != Vector2(0, 0):
		position += velocity * delta

func _unhandled_input(event):
	# Verifica se il tasto "start_game" è premuto e la velocità è zero
	if event.is_action_pressed("start_game") and velocity == Vector2(0, 0):
		start_game()

func start_game():
	# set velocity
	velocity = Vector2(x_direction, -230).normalized() * speed
	print("Gioco iniziato con velocità: ", velocity)
	
func reset_ball(direction):
	# Reset Ball
	set_x_direction(direction)
	position = initial_position
	velocity = Vector2(0, 0)

# var direction: String left or right
func set_x_direction(direction):
	# Reset Ball
	if direction == "right":
		x_direction = 230
	else:
		x_direction = -230


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
