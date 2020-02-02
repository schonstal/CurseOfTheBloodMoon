extends Sprite

export var z_offset = 0
export(NodePath) var hitbox

var copy = false
var reflection:Node

func _ready():
  if !copy:
    reflection = self.duplicate()
    reflection.copy = true
    call_deferred("add_child", reflection)
    reflection.flip_v = true

func _process(delta):
  if copy:
    return

  reflection.region_rect = region_rect
  reflection.region_enabled = region_enabled
  reflection.global_position.y = global_position.y - position.y + z_offset
  if hitbox != null:
    reflection.global_position = reflection.global_position
  reflection.frame = frame
  reflection.offset = offset
  reflection.modulate = Color(1, 1, 1, 0.2)
