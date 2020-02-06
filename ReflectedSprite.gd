extends Sprite

export var z_offset = 0

var copy = false
var reflection:Node
var flip = true

func _ready():
  if !copy:
    reflection = self.duplicate()
    reflection.copy = true
    call_deferred("add_child", reflection)
    reflection.flip_v = flip

func _process(delta):
  if copy:
    return

  reflection.flip_v = flip

  reflection.region_rect = region_rect
  reflection.region_enabled = region_enabled

  if z_offset:
    reflection.global_position = global_position + Vector2(0, z_offset)
  else:
    reflection.global_position = global_position + Vector2(0, -position.y)

  reflection.frame = frame
  reflection.offset = offset
  reflection.modulate = Color(1, 1, 1, 0.2)
