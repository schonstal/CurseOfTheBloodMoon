extends Button

func _process(delta):
  if Input.is_action_just_pressed("attack"):
    Game.reset()
