extends CollisionShape2D

export var offset = 50

onready var parent = $'..'

func _process(delta):
  global_position.y = parent.global_position.y + offset
