extends Node3D


var verticalspeed = 0
var jumpCount = 1
const movementSpeed = 2000
const Gravity = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CharacterBody3D.move_and_slide()
	var speed = Input.get_axis("left", "right")
	
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
	
	verticalspeed -= Gravity * delta
	$CharacterBody3D.velocity.y = verticalspeed
	$CharacterBody3D.velocity.x = speed * movementSpeed * delta

	#position += Vector3(speed, 0, 0) * 50 * delta
	
