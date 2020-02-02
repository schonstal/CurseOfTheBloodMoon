extends CanvasLayer

signal fade_complete
onready var fade_tween = $Tween
onready var rect = $ColorRect

func _ready():
  fade_tween.connect("tween_completed", self, "_on_FadeTween_tween_completed")

func fade(start_color, end_color, duration):
  fade_tween.interpolate_property(
      rect,
      "color",
      start_color,
      end_color,
      duration,
      Tween.TRANS_LINEAR,
      Tween.EASE_OUT)

  fade_tween.start()

func _on_FadeTween_tween_completed(_object, _key):
  emit_signal("fade_complete")
