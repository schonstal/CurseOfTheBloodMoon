extends Node

func _ready():
  pass

# TODO: Flies
func _on_FlySpawnTimer_timeout():
  fly_spawn_timer.wait_time = max(5.0, 10.0 - (10 * Game.scene.score / 100000.0))

  for index in range(0, 8):
    var fly = spawner_scene.instance()
    var angle = TAU * index / 8
    var radius = 500

    fly.global_position = Game.scene.player.global_position + \
        Vector2(cos(angle), sin(angle)) * \
        radius

    fly.connect("spawn", self, "spawn_fly")
    Game.scene.bodies.call_deferred("add_child", fly)
