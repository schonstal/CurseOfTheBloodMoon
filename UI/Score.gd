extends Label

var previous_score = 0

onready var animation = $AnimationPlayer

func _process(_delta):
  self.text = Util.thousands_string(Game.scene.score)

  if Game.scene.score > previous_score:
    animation.play("EarnedPoints")

  previous_score = Game.scene.score
