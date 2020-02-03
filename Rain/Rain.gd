extends YSort

export(Resource) var rain_scene = preload("res://Rain/Rain.tscn")

onready var spawn_timer = $SpawnTimer

func _ready():
  spawn_timer.connect("timeout", self, "_on_SpawnTimer_timeout")

func _on_SpawnTimer_timeout():
  var rain = rain_scene.instance()
  rain.global_position = Vector2(
      rand_range(-1120, 1120),
      rand_range(-630, 620)
  )

  var size = rand_range(0.25, 0.75)
  rain.scale = Vector2(size, size)

  Game.scene.bodies.add_child(rain)
