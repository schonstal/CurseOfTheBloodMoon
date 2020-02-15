extends Control

var started = false

func _process(delta):
  if !started && (Input.is_action_just_pressed("melee") || Input.is_action_just_pressed("shoot")):
    started = true
    Game.reset()
