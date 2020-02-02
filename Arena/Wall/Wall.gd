extends StaticBody2D

export var width_tiles = 1

onready var top = $WallTop
onready var side = $WallSide
onready var body = $CollisionShape2D

func _ready():
  body.shape.extents.x = width_tiles * 31.5
  top.region_rect = Rect2(0, 0, 63 * width_tiles, 24)
  side.region_rect = Rect2(0, 0, 63 * width_tiles, 60)
