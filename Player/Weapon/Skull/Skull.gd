extends Sprite

onready var parent = $'..'
onready var animation = $AnimationPlayer

func _process(delta):
  var anim = parent.facing
  if parent.shooting:
    anim = "%s%s" % [parent.facing, "Attack"]

  animation.play(anim)
