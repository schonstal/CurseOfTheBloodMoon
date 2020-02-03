extends YSort

onready var bat_spawn_timer = $BatSpawnTimer
onready var turret_spawn_timer = $TurretSpawnTimer

var spawn_scene = preload("res://Enemies/EnemySpawn/Spawner.tscn")
var bat_scene = preload("res://Enemies/Bat/Bat.tscn")
var turret_scene = preload("res://Enemies/Turret/Turret.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
  bat_spawn_timer.connect("timeout", self, "_on_BatSpawnTimer_timeout")
  turret_spawn_timer.connect("timeout", self, "_on_TurretSpawnTimer_timeout")

func _on_BatSpawnTimer_timeout():
  bat_spawn_timer.wait_time = max(0.5, 3.0 - (3 * Game.scene.score / 30000.0))

  var spawn = spawn_scene.instance()
  spawn.global_position = Vector2(
      rand_range(-1000, 1000),
      rand_range(600, -600)
    )
  Game.scene.bodies.call_deferred("add_child", spawn)
  spawn.connect("spawn", self, "spawn_bat")

func _on_TurretSpawnTimer_timeout():
  turret_spawn_timer.wait_time = max(2.0, 6.0 - (6 * Game.scene.score / 30000.0))

  var spawn = spawn_scene.instance()
  spawn.global_position = Vector2(
      rand_range(-1000, 1000),
      rand_range(600, -600)
    )
  Game.scene.bodies.call_deferred("add_child", spawn)
  spawn.connect("spawn", self, "spawn_turret")

func spawn_bat(position):
  var spawn = bat_scene.instance()
  spawn.global_position = position
  Game.scene.bodies.call_deferred("add_child", spawn)

func spawn_turret(position):
  var spawn = turret_scene.instance()
  spawn.global_position = position
  Game.scene.bodies.call_deferred("add_child", spawn)

