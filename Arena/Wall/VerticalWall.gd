extends StaticBody2D

export var height_tiles = 1

onready var top = $WallTop
onready var body = $CollisionShape2D

func _ready():
  body.shape.extents.y = height_tiles * 12
  top.region_rect = Rect2(0, 0, 63, 24 * height_tiles)
