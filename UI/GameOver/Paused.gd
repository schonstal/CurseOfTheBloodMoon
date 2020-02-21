extends Control

func _ready():
  pause_mode = Node.PAUSE_MODE_PROCESS

func _process(delta):
  if Game.scene.is_game_over:
    get_tree().paused = false
    visible = false
    return

  visible = get_tree().paused
  if Input.is_action_just_pressed("pause"):
    get_tree().paused = !get_tree().paused
