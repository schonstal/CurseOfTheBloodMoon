extends Node2D

export var speed = 300

onready var player = Game.scene.player
onready var parent = $'..'

func _ready():
  speed = speed * rand_range(0.5, 1.0)

func _process(delta):
  if is_instance_valid(player):
    var direction = player.global_position - global_position
    direction = direction.normalized()

    parent.velocity = speed * direction
  else:
    parent.velocity = Vector2.ZERO
