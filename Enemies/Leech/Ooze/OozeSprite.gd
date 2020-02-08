extends Sprite

onready var flash_timer = $FlashTimer

func _ready():
  frame = randi() % 2

func _process(delta):
  var time = OS.get_ticks_msec()
  var int_time = int(time / 100)

  if int_time % 2 == 0:
    modulate = Color(1, 1, 1, 1)
  else:
    modulate = Color(1.5, 1.5, 1.5, 1)
