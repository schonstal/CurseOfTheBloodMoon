extends CollisionShape2D

export var offset = 50

onready var parent = $'..'

func _process(_delta):
  global_position = parent.global_position + Vector2(0, offset)
