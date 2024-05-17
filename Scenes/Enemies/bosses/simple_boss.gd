extends Node2D
class_name BossBase

var state : Enemies.State
@onready var path_follow_2d = $Paths/Path2D/PathFollow2D

@export var invulnerable_time: float = 0.3
@onready var invulnerable_timer = $Timers/InvulnerableTimer
@onready var weapon_timer = $Timers/WeaponTimer
@onready var weapon_mounts_node = $Paths/Path2D/PathFollow2D/CharacterBody2D/EnemyWeapon/WeaponMounts

@export var enemy_weapon : WeaponBase
@export var health : int = 4
var speed : float = 100.0
var dir: Vector2 = Vector2.DOWN
var is_vulnerable : bool = true
var can_shoot : bool = true
var weapon_cooldown : float = 1

signal enemy_shoot(pos : Vector2, dir : Vector2, projectile: ProjectileBase)

func shoot():
	if can_shoot:
		for mount in weapon_mounts_node.get_children():
			# change direction to one going for player?
			var wp = mount.get_child(0) as WeaponBase
			var projectiles = wp.fire(mount.global_position, dir)
			for projectile in projectiles:
				enemy_shoot.emit(mount.global_position,dir, projectile)
			
		can_shoot = false
		weapon_timer.start(weapon_cooldown)
	
func hit(damage : int):
	if is_vulnerable:
		health-=damage
		is_vulnerable = false
		invulnerable_timer.start(invulnerable_time)
		
	if health <= 0:
		health = 0
		queue_free()

func purge():
	queue_free()

func _on_invulnerable_timer_timeout():
	is_vulnerable = true


func _on_weapon_timer_timeout():
	can_shoot = true

func _physics_process(delta):
	# enemy shooting
	progress_path(delta)
	shoot()

# Mostly for boss enemy
func change_state():
	match(state):
		Enemies.IDLE:
			pass
		Enemies.MOVE:
			pass
		Enemies.SHOOTING:
			pass

func progress_path(delta):
	path_follow_2d.progress_ratio += delta*0.1
