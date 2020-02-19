tool
extends Node2D

export var length = 500.0

onready var right = $Right
onready var middle = $Middle

var length_was = 0.0
var height = 65

func _ready():
  height = middle.region_rect.size.y

func _process(_delta):
  if length != length_was:
    middle.region_rect = Rect2(0, 0, length, height)
    right.position.x = length + 281

    length_was = length
