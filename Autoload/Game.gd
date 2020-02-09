extends Node

var scene:Node

#warning-ignore:unused_class_variable
var high_score = 0
var target_scene

func initialize():
  scene = $'../World'

func _ready():
  randomize()
  Overlay.connect("fade_complete", self, "_on_Overlay_fade_complete")
  Transition.connect("transition_complete", self, "_on_Transition_complete")

func reset():
  Game.change_scene("res://Scenes/Gameplay.tscn", false)

func change_scene(scene, fade_music = true):
  target_scene = scene
  # Overlay.fade(Color(0, 0, 0, 0), Color(0, 0, 0, 1), 0.3)
  Transition.transition_out()

  if fade_music:
    MusicPlayer.fade(MusicPlayer.music_volume, -80, 0.3)

func _on_Transition_complete():
  if target_scene != null:
    var scene = target_scene
    target_scene = null
    yield(get_tree().create_timer(0.5), "timeout")
    get_tree().change_scene(scene)
    Transition.transition_in()
    MusicPlayer.fade(MusicPlayer.music_volume, 0, 0.2)
    MusicPlayer.disable_filter()

func _on_Overlay_fade_complete():
  pass
