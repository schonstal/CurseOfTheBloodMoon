extends Node2D

var positions = ["E", "NE", "N", "NW", "W", "SW", "S", "SE"]

export var distance = 50.0

onready var sprite = $Skull
onready var animation = $Skull/AnimationPlayer

var direction = Vector2(0, 0)
var aim_direction = Vector2(0, 0)
var facing = "E"
var shooting = false

func _process(delta):
  aim()

func aim():
  direction.x = Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left")
  direction.y = Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")

  if direction.length() > 0.4:
    aim_direction = direction.normalized()
    position = aim_direction * distance
    var angle_rad = aim_direction.angle() + PI + PI / 8
    var angle_ratio = angle_rad / (TAU + PI / 8)
    var anim_index = angle_ratio * positions.size()
    facing = positions[int(anim_index)]
    var anim = facing
    if shooting:
      anim = "%s%s" % [facing, "Attack"]
    animation.play(anim)

