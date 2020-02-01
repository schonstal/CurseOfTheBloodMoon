extends KinematicBody2D

export var run_speed = 300.0

var velocity = Vector2(0, 0)
var acceleration = Vector2(0, 0)

func _ready():
  pass

func _physics_process(delta):
  handle_movement()
  move_and_slide(velocity)

func handle_movement():
  var direction = Vector2(0, 0)

  if Input.is_action_pressed("move_left"):
    direction.x = -1
  elif Input.is_action_pressed("move_right"):
    direction.x = 1

  if Input.is_action_pressed("move_up"):
    direction.y = -1
  elif Input.is_action_pressed("move_down"):
    direction.y = 1

  direction = direction.normalized()

  velocity = direction * run_speed


