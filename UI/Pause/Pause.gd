extends Control

var pause_menu = preload("res://UI/Pause/PauseMenu.tscn")
var pause_scene

func _input(event):
  if Game.scene.is_game_over:
    return

  if event.is_action_pressed("pause"):
    var paused = get_tree().paused

    if paused:
      unpause()
    else:
      pause()

func pause():
  get_tree().paused = true
  visible = true

  if pause_scene == null:
    pause_scene = pause_menu.instance()
    add_child(pause_scene)

  MusicPlayer.enable_filter()
  pause_scene.focus()

func unpause():
  MusicPlayer.disable_filter()
  get_tree().paused = false
  visible = false
