extends Sprite

var pulse_phase = 0.0

func _process(delta):
  var player = Game.scene.player
  if player.health < 250 && player.alive:
    visible = true
    modulate = Color(1, 1, 1, ((300 - player.health) / 250) * 0.3)
  else:
    visible = false
    pulse_phase = 0


