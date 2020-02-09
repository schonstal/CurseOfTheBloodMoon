extends Node2D

export var speed = 300
export var change_direction_chance = 0.25
export var move_direction = Vector2(0, 0)

onready var parent = $'..'
onready var animation = $'../Sprite/AnimationPlayer'
onready var ooze_spawn = $OozeSpawn

var directions = ["North", "East", "South", "West"]
var direction = 0

func _ready():
  direction = randi() % directions.size()
  start_moving()

func move():
  parent.velocity = move_direction * speed
  parent.acceleration = move_direction * -speed * 2
  if direction == 0 || direction == 2:
    ooze_spawn.spawn_ooze(true)
  else:
    ooze_spawn.spawn_ooze(false)

func move_complete():
  parent.velocity = Vector2.ZERO
  parent.acceleration = Vector2.ZERO

  if randf() < change_direction_chance:
    change_direction()

  start_moving()

func change_direction():
  if direction == 0 || direction == 2:
    direction = random_choice(1, 3)
  else:
    direction = random_choice(0, 2)

func start_moving():
  animation.play("Walk%s" % directions[direction])

func random_choice(a, b):
  if randi() % 2 == 0:
    return a
  else:
    return b
