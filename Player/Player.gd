extends KinematicBody2D

export var run_speed = 300.0

const RIGHT = -1
const LEFT = 1

var velocity = Vector2(0, 0)
var acceleration = Vector2(0, 0)

var facing = LEFT setget set_facing,get_facing

onready var animation = $Body/AnimationPlayer

func _ready():
  pass

func _physics_process(delta):
  handle_movement()
  velocity = move_and_slide(velocity)

  if velocity.length() > 0:
    animation.play("Run")
  else:
    animation.play("Idle")

func handle_movement():
  var direction = Vector2(0, 0)

  if Input.is_action_pressed("move_left"):
    direction.x = -1
    self.facing = LEFT
  elif Input.is_action_pressed("move_right"):
    direction.x = 1
    self.facing = RIGHT

  if Input.is_action_pressed("move_up"):
    direction.y = -1
  elif Input.is_action_pressed("move_down"):
    direction.y = 1

  direction = direction.normalized()

  velocity = direction * run_speed


func set_facing(value):
  if value != RIGHT:
    value = LEFT

  apply_scale(Vector2(value * facing, 1))
  facing = value

func get_facing():
  return facing
