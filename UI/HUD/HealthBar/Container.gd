tool
extends Node2D

export var length = 500.0

onready var right = $Right
onready var middle = $Middle

var length_was = 0.0

func _process(_delta):
  if length != length_was:
    middle.region_rect = Rect2(0, 0, length, 30)
    right.position.x = length + 119

    length_was = length
