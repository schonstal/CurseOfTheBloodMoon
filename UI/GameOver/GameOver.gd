extends Control

var started = false

func _process(_delta):
  if !started && (Input.is_action_just_pressed("melee") || Input.is_action_just_pressed("shoot") || Input.is_action_just_pressed("start")):
    started = true
    Game.reset()
