extends CanvasLayer

onready var tween = $Tween
onready var left = $Left
onready var right = $Right

var width = 0
var shake_time = 0

signal transition_complete

func _ready():
  width = left.texture.get_width()
  left.position.x = -width
  right.position.x = 1920

  tween.connect("tween_completed", self, "_on_Tween_completed")

func _process(delta):
  if shake_time > 0:
    offset.x = rand_range(-20, 20)
    offset.y = rand_range(-20, 20)
    shake_time -= delta
  else:
    offset = Vector2.ZERO

func transition_out():
  var vp_width = 1920

  tween.interpolate_property(
      left,
      "position",
      Vector2(-width, 0),
      Vector2(vp_width / 2 - width, 0),
      0.5,
      Tween.TRANS_QUART,
      Tween.EASE_IN)

  tween.interpolate_property(
      right,
      "position",
      Vector2(vp_width, 0),
      Vector2(vp_width / 2, 0),
      0.5,
      Tween.TRANS_QUART,
      Tween.EASE_IN)

  tween.start()

func transition_in():
  var vp_width = 1920

  tween.interpolate_property(
      left,
      "position",
      Vector2(vp_width / 2 - width, 0),
      Vector2(-width, 0),
      0.5,
      Tween.TRANS_QUART,
      Tween.EASE_IN)

  tween.interpolate_property(
      right,
      "position",
      Vector2(vp_width / 2, 0),
      Vector2(vp_width, 0),
      0.5,
      Tween.TRANS_QUART,
      Tween.EASE_IN)

  tween.start()

func _on_Tween_completed(_object, _key):
  emit_signal("transition_complete")

  if right.position.x < 1000:
    shake_time = 0.5
