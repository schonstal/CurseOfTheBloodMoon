extends StaticBody2D

export var width_tiles = 1

onready var top = $WallTop
onready var side = $WallSide

func _ready():
  top.region_rect = Rect2(0, 0, 65 * width_tiles, 27)
  side.region_rect = Rect2(0, 0, 65 * width_tiles, 27)
