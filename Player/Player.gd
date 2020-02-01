extends KinematicBody2D

export var run_speed = 300.0

const RIGHT = -1
const LEFT = 1

var velocity = Vector2(0, 0)
var acceleration = Vector2(0, 0)

var facing = LEFT setget set_facing,get_facing

onready var animation = $YSort/Body/AnimationPlayer

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

  direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
  direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

  if direction.length() > 0.3:
    velocity = direction * run_speed
  else:
    velocity = Vector2.ZERO


func set_facing(value):
  if value != RIGHT:
    value = LEFT

  apply_scale(Vector2(value * facing, 1))
  facing = value

func get_facing():
  return facing
