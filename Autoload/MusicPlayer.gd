extends AudioStreamPlayer

var bus_effect:AudioEffectLowPassFilter
var bus_index = 0
var effect_index = 0
var music_volume = 0
var current_file = ""

onready var fade_tween = $FadeTween

func _ready():
  bus_index = AudioServer.get_bus_index("Music")

  bus_effect = AudioEffectLowPassFilter.new()
  bus_effect.cutoff_hz = 22000

  AudioServer.add_bus_effect(bus_index, bus_effect, effect_index)

func _process(_delta):
  AudioServer.set_bus_volume_db(bus_index, music_volume)

func play_file(audio_file):
  if audio_file == current_file:
    return

  current_file = audio_file

  self.stream = load(audio_file)
  self.play()

func disable_filter():
  bus_effect.cutoff_hz = 22000

func enable_filter():
  bus_effect.cutoff_hz = 200

func fade(start_volume_db, end_volume_db, duration):
  fade_tween.interpolate_property(
      self,
      "music_volume",
      start_volume_db,
      end_volume_db,
      duration,
      Tween.TRANS_QUAD,
      Tween.EASE_IN)

  fade_tween.start()

func _on_boss_defeated():
  self.stop()#  pass
