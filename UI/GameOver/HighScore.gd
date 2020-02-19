extends Label

func _ready():
  text = "Best: %s" % Util.thousands_string(Game.high_score)
