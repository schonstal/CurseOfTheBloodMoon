extends Sprite

onready var animation = $AnimationPlayer

onready var color_tween = $ColorTween
onready var scale_tween = $ScaleTween
onready var position_tween = $PositionTween

var min_scale = 0.2
var max_scale = 1.0
var duration = 1.0

var bpm = 0.46875
var accum = bpm
var animating = false
var previous_beat_time = 0.0

onready var start_position = position

func _ready():
  EventBus.connect("combo_increased", self, "_on_combo_increased")
  EventBus.connect("reset_combo", self, "_on_reset_combo")
  color_tween.connect("tween_completed", self, "_on_ColorTween_tween_completed")
  scale_tween.connect("tween_completed", self, "_on_ScaleTween_tween_completed")

  visible = false

func _process(delta):
  min_scale = 0.3 + Game.scene.combo / 40.0

  var music_time = MusicPlayer.get_playback_position() +\
                   AudioServer.get_time_since_last_mix() -\
                   AudioServer.get_output_latency()

  if !animating && fmod(music_time, bpm) < 0.1:
    animating = true

    scale_tween.interpolate_property(
        self,
        "scale",
        Vector2(min_scale + 0.05, min_scale + 0.05),
        Vector2(min_scale, min_scale),
        0.2,
        Tween.TRANS_QUAD,
        Tween.EASE_IN)

    scale_tween.start()

func _on_combo_increased(combo):
  if combo > 1:
    animating = true
    visible = true
    frame = combo - 2

    color_tween.stop_all()
    scale_tween.stop_all()
    position_tween.stop_all()

    modulate = Color(10, 10, 10, 1)
    color_tween.interpolate_property(
        self,
        "modulate",
        Color(10, 10, 10, 1),
        Color(1, 1, 1, 1),
        0.5,
        Tween.TRANS_QUART,
        Tween.EASE_IN)

    color_tween.start()

    scale_tween.interpolate_property(
        self,
        "scale",
        Vector2(max_scale, max_scale),
        Vector2(min_scale, min_scale),
        0.5,
        Tween.TRANS_QUART,
        Tween.EASE_IN)

    scale_tween.start()

    position_tween.interpolate_property(
        self,
        "position",
        Vector2(100, 162),
        start_position,
        0.5,
        Tween.TRANS_QUART,
        Tween.EASE_IN)

    position_tween.start()

func _on_reset_combo():
  visible = false

func _on_ColorTween_tween_completed(_object, _key):
  pass

func _on_ScaleTween_tween_completed(_object, _key):
  animating = false
