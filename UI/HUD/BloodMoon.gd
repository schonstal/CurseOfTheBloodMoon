extends Sprite

var bpm = 0.46875
var animating = false

onready var animation = $AnimationPlayer
onready var scale_tween = $ScaleTween

func _ready():
  EventBus.connect("combo_increased", self, "_on_combo_increased")
  EventBus.connect("reset_combo", self, "_on_reset_combo")
  scale_tween.connect("tween_completed", self, "_on_ScaleTween_tween_completed")

func _process(delta):
  var music_time = MusicPlayer.get_playback_position() +\
                   AudioServer.get_time_since_last_mix() -\
                   AudioServer.get_output_latency()

  if Game.scene.combo >= Game.scene.max_combo && !animating && fmod(music_time, bpm) < 0.1:
    animating = true

    scale_tween.interpolate_property(
        self,
        "scale",
        Vector2(0.55, 0.55),
        Vector2(0.5, 0.5),
        0.2,
        Tween.TRANS_QUAD,
        Tween.EASE_IN)

    scale_tween.start()

func _on_combo_increased(combo):
  if combo >= 2:
    self.scale = Vector2(0.5, 0.5)
    self.visible = true
    self.frame = Game.scene.combo - 2
  else:
    self.frame = 0
    self.visible = false

  if combo >= Game.scene.max_combo:
    self.frame = 8

func _on_reset_combo():
  self.frame = 0
  self.visible = false

func _on_ScaleTween_tween_completed(_object, _key):
  animating = false
