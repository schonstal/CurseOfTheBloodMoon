extends AudioStreamPlayer

var low_pass:AudioEffectLowPassFilter
var spectrum_analyzer:AudioEffectSpectrumAnalyzer
var spectrum:AudioEffectSpectrumAnalyzerInstance
var bus_index = 0
var low_pass_index = 0
var spectrum_analyzer_index = 1
var music_volume = 0
var current_file = ""

var bass_magnitude setget ,get_bass_magnitude

onready var fade_tween = $FadeTween

func _ready():
  bus_index = AudioServer.get_bus_index("Music")

  low_pass = AudioEffectLowPassFilter.new()
  low_pass.cutoff_hz = 22000

  spectrum_analyzer = AudioEffectSpectrumAnalyzer.new()

  AudioServer.add_bus_effect(bus_index, low_pass, low_pass_index)
  AudioServer.add_bus_effect(bus_index, spectrum_analyzer, spectrum_analyzer_index)

  spectrum = AudioServer.get_bus_effect_instance(bus_index, spectrum_analyzer_index)

func _process(_delta):
  AudioServer.set_bus_volume_db(bus_index, music_volume)

func play_file(audio_file):
  if audio_file == current_file:
    return

  current_file = audio_file

  self.stream = load(audio_file)
  self.play()

func disable_filter():
  low_pass.cutoff_hz = 22000

func enable_filter():
  low_pass.cutoff_hz = 200

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

func get_bass_magnitude():
  return spectrum.get_magnitude_for_frequency_range(40, 100).length()

func _on_boss_defeated():
  self.stop()#  pass
