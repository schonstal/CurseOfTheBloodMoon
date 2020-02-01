extends Node2D

export var distance = 50.0

onready var sprite = $Sprite

var direction = Vector2(0, 0)

func _process(delta):
  aim()

func aim():
  direction.x = Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left")
  direction.y = Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")

  if direction.length() > 0.4:
    position = direction.normalized() * distance
    sprite.rotation = direction.angle() + PI / 2
