extends Sprite

onready var animation = $AnimationPlayer

func _ready():
  EventBus.connect("combo_increased", self, "_on_combo_increased")

func _on_combo_increased(combo):
  animation.play("Combo")
