extends Control

func _process(delta):
  if Input.is_action_just_pressed("melee") || Input.is_action_just_pressed("shoot"):
    Game.reset()
