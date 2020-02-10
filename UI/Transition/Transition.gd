extends CanvasLayer

export var shake_duration = 0.25
export var tween_in_duration = 0.25
export var tween_out_duration = 0.25

onready var tween = $Tween
onready var left = $Left
onready var right = $Right
onready var start_sound = $StartSound
onready var end_sound = $EndSound

var width = 0
var shake_time = 0
var vp_width = 1920

var left_origin
var right_origin

signal transition_complete

func _ready():
  width = left.texture.get_width()
  left.position.x = -width - 150
  right.position.x = vp_width + 150
  left.visible = true
  right.visible = true

  left_origin = left.position.x
  right_origin = right.position.x

  tween.connect("tween_completed", self, "_on_Tween_completed")

func _process(delta):
  if shake_time > 0:
    offset.x = rand_range(-20, 20)
    offset.y = rand_range(-20, 20)
    shake_time -= delta
  else:
    offset = Vector2.ZERO

func transition_out():
  start_sound.play()

  tween.interpolate_property(
      left,
      "position",
      Vector2(left_origin, -25),
      Vector2(vp_width / 2 - width, -25),
      tween_in_duration,
      Tween.TRANS_QUART,
      Tween.EASE_IN)

  tween.interpolate_property(
      right,
      "position",
      Vector2(right_origin, -25),
      Vector2(vp_width / 2, -25),
      tween_in_duration,
      Tween.TRANS_QUART,
      Tween.EASE_IN)

  tween.start()

func transition_in():
  start_sound.play()

  tween.interpolate_property(
      left,
      "position",
      Vector2(vp_width / 2 - width, -25),
      Vector2(left_origin, -25),
      tween_out_duration,
      Tween.TRANS_QUART,
      Tween.EASE_IN)

  tween.interpolate_property(
      right,
      "position",
      Vector2(vp_width / 2, -25),
      Vector2(right_origin, -25),
      tween_out_duration,
      Tween.TRANS_QUART,
      Tween.EASE_IN)

  tween.start()

func _on_Tween_completed(_object, _key):
  emit_signal("transition_complete")

  if right.position.x < 1000:
    shake_time = shake_duration
    end_sound.play()
