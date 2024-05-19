extends CharacterBody2D
class_name BossBody

var state : Enemies.State

@export var invulnerable_time: float = 0.3
@onready var invulnerable_timer = $Timers/InvulnerableTimer
@onready var weapon_timer = $Timers/WeaponTimer
@onready var weapon_mounts_node = $EnemyWeapon/WeaponMounts

@export var enemy_weapon : WeaponBase
@export var health : int = 4
@export var point_value : int = 1000
@export var collision_damage : int = 10
@export var death_particle : PackedScene

var speed : float = 100.0
var dir: Vector2 = Vector2.DOWN
var is_vulnerable : bool = true
var can_shoot : bool = true
var weapon_cooldown : float = 1

signal boss_shoot(pos : Vector2, dir : Vector2, projectile: ProjectileBase)
signal boss_died()

func _physics_process(delta):
	# enemy shooting
	shoot()

func shoot():
	if can_shoot:
		for mount in weapon_mounts_node.get_children():
			# change direction to one going for player?
			var wp = mount.get_child(0) as WeaponBase
			var projectiles = wp.fire(mount.global_position, dir)
			for projectile in projectiles:
				boss_shoot.emit(mount.global_position,dir, projectile)
			
		can_shoot = false
		weapon_timer.start(weapon_cooldown)
	
func hit(damage : int):
	if is_vulnerable:
		health-=damage
		is_vulnerable = false
		invulnerable_timer.start(invulnerable_time)
		AudioPlayer.play_FX(AudioPlayer.hit_sound, -15.0)
		

	if health <= 0:
		health = 0
		Player.player_score += point_value
		var particle = death_particle.instantiate()
		particle.position = global_position
		particle.rotation = global_rotation
		particle.emitting = true
		get_tree().current_scene.add_child(particle)
		boss_died.emit()
		queue_free()

func purge():
	queue_free()

func _on_invulnerable_timer_timeout():
	is_vulnerable = true

func _on_weapon_timer_timeout():
	can_shoot = true

# Mostly for boss enemy
func change_state():
	match(state):
		Enemies.IDLE:
			pass
		Enemies.MOVE:
			pass
		Enemies.SHOOTING:
			pass


func _on_hurt_area_body_entered(body):
	if "hit" in body:
		body.hit(collision_damage)
		hit(Player.ram_damage)
