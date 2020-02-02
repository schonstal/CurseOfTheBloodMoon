extends Sprite

onready var flash_tween = $FlashTween

func _ready():
  EventBus.connect("shield_failure", self, "_on_shield_fauilure")

func flash():
  flash_tween.interpolate_property(
      self,
      "modulate",
      Color(10, 10, 10, 1),
      Color(1, 1, 1, 1),
      0.5,
      Tween.TRANS_QUART,
      Tween.EASE_OUT)

  flash_tween.start()

func _on_shield_fauilure():
  flash()
