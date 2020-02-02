extends Node2D

export var distance = 50.0

onready var sprite = $Sprite

var direction = Vector2(0, 0)
var aim_direction = Vector2(0, 0)

func _process(delta):
  aim()

func aim():
  direction.x = Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left")
  direction.y = Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")

  if direction.length() > 0.4:
    aim_direction = direction.normalized()
    position = aim_direction * distance
    sprite.rotation = direction.angle() + PI / 2
