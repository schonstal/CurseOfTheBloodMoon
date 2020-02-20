extends Node

onready var bat_spawn_timer = $BatSpawnTimer
onready var turret_spawn_timer = $TurretSpawnTimer
onready var dog_spawn_timer = $DogSpawnTimer
onready var fly_spawn_timer = $FlySpawnTimer

var spawn_scene = preload("res://Enemies/EnemySpawn/Spawner.tscn")
var bat_scene = preload("res://Enemies/Bat/Bat.tscn")
var turret_scene = preload("res://Enemies/Turret/Turret.tscn")
var dog_scene = preload("res://Enemies/Doggo/Doggo.tscn")
var fly_scene = preload("res://Enemies/Fly/Fly.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
  return
  bat_spawn_timer.connect("timeout", self, "_on_BatSpawnTimer_timeout")
  turret_spawn_timer.connect("timeout", self, "_on_TurretSpawnTimer_timeout")
  dog_spawn_timer.connect("timeout", self, "_on_DogSpawnTimer_timeout")
  fly_spawn_timer.connect("timeout", self, "_on_FlySpawnTimer_timeout")

func _on_FlySpawnTimer_timeout():
  fly_spawn_timer.wait_time = max(5.0, 10.0 - (10 * Game.scene.score / 100000.0))

  for index in range(0, 8):
    var fly = spawn_scene.instance()
    var angle = TAU * index / 8
    var radius = 500

    fly.global_position = Game.scene.player.global_position + \
        Vector2(cos(angle), sin(angle)) * \
        radius

    fly.connect("spawn", self, "spawn_fly")
    Game.scene.bodies.call_deferred("add_child", fly)

func _on_BatSpawnTimer_timeout():
  bat_spawn_timer.wait_time = max(2.0, 4.0 - (4 * Game.scene.score / 100000.0))

  var spawn = spawn_scene.instance()
  spawn.global_position = Vector2(
      rand_range(-1000, 1000),
      rand_range(600, -600)
    )
  Game.scene.bodies.call_deferred("add_child", spawn)
  spawn.connect("spawn", self, "spawn_bat")

func _on_TurretSpawnTimer_timeout():
  turret_spawn_timer.wait_time = max(8.0, 15.0 - (15 * Game.scene.score / 100000.0))

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

func spawn_fly(position):
  var spawn = fly_scene.instance()
  spawn.global_position = position
  Game.scene.bodies.call_deferred("add_child", spawn)
