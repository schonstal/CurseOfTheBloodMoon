extends Control

func _ready():
  pause_mode = Node.PAUSE_MODE_PROCESS
  
func _process(delta):
  visible = get_tree().paused
  if Input.is_action_just_pressed("start"):
    get_tree().paused = !get_tree().paused
