extends YSort

onready var bat_spawn_timer = $BatSpawnTimer
onready var turret_spawn_timer = $TurretSpawnTimer
onready var dog_spawn_timer = $DogSpawnTimer

var spawn_scene = preload("res://Enemies/EnemySpawn/Spawner.tscn")
var bat_scene = preload("res://Enemies/Bat/Bat.tscn")
var turret_scene = preload("res://Enemies/Turret/Turret.tscn")
var dog_scene = preload("res://Enemies/Doggo/Doggo.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
  bat_spawn_timer.connect("timeout", self, "_on_BatSpawnTimer_timeout")
  turret_spawn_timer.connect("timeout", self, "_on_TurretSpawnTimer_timeout")
  dog_spawn_timer.connect("timeout", self, "_on_DogSpawnTimer_timeout")

func _on_BatSpawnTimer_timeout():
  bat_spawn_timer.wait_time = max(1.0, 2.0 - (2 * Game.scene.score / 100000.0))

  var spawn = spawn_scene.instance()
  spawn.global_position = Vector2(
      rand_range(-1000, 1000),
      rand_range(600, -600)
    )
  Game.scene.bodies.call_deferred("add_child", spawn)
  spawn.connect("spawn", self, "spawn_bat")

func _on_TurretSpawnTimer_timeout():
  turret_spawn_timer.wait_time = max(6.0, 15.0 - (15 * Game.scene.score / 100000.0))

  var spawn = spawn_scene.instance()
  spawn.global_position = Vector2(
      rand_range(-1000, 1000),
      rand_range(600, -600)
    )
  Game.scene.bodies.call_deferred("add_child", spawn)
  spawn.connect("spawn", self, "spawn_turret")

func _on_DogSpawnTimer_timeout():
  dog_spawn_timer.wait_time = max(15.0, 20.0 - (20 * Game.scene.score / 100000.0))

  var spawn = spawn_scene.instance()
  spawn.global_position = Vector2(
      rand_range(-1000, 1000),
      rand_range(600, -600)
    )
  Game.scene.bodies.call_deferred("add_child", spawn)
  spawn.connect("spawn", self, "spawn_dog")

func spawn_bat(position):
  var spawn = bat_scene.instance()
  spawn.global_position = position
  Game.scene.bodies.call_deferred("add_child", spawn)

func spawn_turret(position):
  var spawn = turret_scene.instance()
  spawn.global_position = position
  Game.scene.bodies.call_deferred("add_child", spawn)

func spawn_dog(position):
  var spawn = dog_scene.instance()
  spawn.global_position = position
  Game.scene.bodies.call_deferred("add_child", spawn)
