tool
extends Node2D

export var length = 500.0

onready var left = $Left
onready var right = $Right
onready var bottom = $Bottom

var length_was = 0.0

func _process(_delta):
  if length != length_was:
    left.region_rect = Rect2(0, 0, 27, length)
    right.region_rect = Rect2(0, 0, 27, length)
    bottom.position.y = left.position.y + length + 50

    length_was = length
