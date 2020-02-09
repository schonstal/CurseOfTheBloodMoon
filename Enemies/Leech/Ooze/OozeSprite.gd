extends Sprite

export var flash = false

onready var parent = $'..'

func _ready():
  frame = randi() % 3

func _process(delta):
  if flash:
    var time = OS.get_ticks_msec()
    var int_time = int(time / 100)

    if int_time % 2 == 0:
      parent.modulate = Color(1, 1, 1, 1)
    else:
      parent.modulate = Color(1.5, 1.5, 1.5, 1)
