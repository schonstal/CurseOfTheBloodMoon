extends Label

var previous_score = 0

onready var animation = $AnimationPlayer
onready var high_score_animation = $HighScoreAnimation

func _process(_delta):
  self.text = Util.thousands_string(Game.scene.score)

  if Game.scene.score > previous_score:
    animation.play("EarnedPoints")

  if Game.scene.score >= Game.high_score:
    high_score_animation.play("HighScore")

  previous_score = Game.scene.score
