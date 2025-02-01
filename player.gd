extends Node3D


var verticalspeed = 0
var jumpCount = 1
var isDashing = false
var canDash = true
const movementSpeed = 2000
const Gravity = 50
const Dashspeed = 10000
var speed = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CharacterBody3D.move_and_slide()
	speed = Input.get_axis("left", "right")
	spriteDirection()
	print(speed)
	
	if(Input.is_action_just_pressed("jump") and jumpCount > 0):
		if($CharacterBody3D.is_on_floor()):
			verticalspeed = 20
		else:
			verticalspeed = 20
			jumpCount -=1
		
		
	if(Input.is_action_just_released("jump") and jumpCount > 0):
		verticalspeed = 0
		
	if $CharacterBody3D.is_on_floor() and !Input.is_action_just_pressed("jump"):
		verticalspeed = 0
		jumpCount = 1
	
	if $CharacterBody3D.is_on_ceiling():
		verticalspeed = 0
		
	if Input.is_action_just_pressed("dash") and canDash:
		isDashing = true
		canDash = false
		verticalspeed = 0
		$CharacterBody3D/dashTimer.start()
		$CharacterBody3D/canDashTimer.start()
	
	verticalspeed -= Gravity * delta
	$CharacterBody3D.velocity.y = verticalspeed
	
	if(isDashing):
		$CharacterBody3D.velocity.x = speed * Dashspeed * delta	
	else: $CharacterBody3D.velocity.x = speed * movementSpeed * delta	


func spriteDirection():
	if speed == -1:
		$CharacterBody3D/Sprite3D.flip_h = true
	else: $CharacterBody3D/Sprite3D.flip_h = false

func _on_dash_timer_timeout() -> void:
	isDashing = false

func _on_can_dash_timer_timeout() -> void:
	canDash = true
