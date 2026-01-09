##
##
@icon("res://assets/icons/classes/driver.svg")
class_name Driver
extends Node

signal moving_changed(moving: bool)

const STATUS_NOT_READY: int = 0
const STATUS_IDLE: int = 1
const STATUS_MOVING: int = 2

@export var initial_velocity: Vector2

var force: Vector2 = Vector2.ZERO:
	set(value):
		force = value

		if not is_physics_processing() and not force.is_zero_approx():
			set_physics_process(true)
			_status = STATUS_MOVING
			moving_changed.emit(true)

var _velocity: Vector2
var _status: int = STATUS_NOT_READY

@onready var _body: Body = owner

# =============================================================
# ========= Public Functions ==================================


func stop() -> void:
	_velocity = Vector2.ZERO
	force = Vector2.ZERO


func is_moving() -> bool:
	return _status == STATUS_MOVING

# =============================================================
# ========= Callbacks =========================================


func _ready() -> void:
	_velocity = initial_velocity

	if not _velocity.is_zero_approx() or not force.is_zero_approx():
		moving_changed.emit(true)
		_status = STATUS_MOVING
	else:
		_status = STATUS_IDLE


func _physics_process(delta: float) -> void:
	var acceleration: Vector2 = force / _body.mass
	var new_velocity: Vector2 = _velocity + acceleration * delta
	_body.position = _body.position + new_velocity * delta
	_velocity = new_velocity

	if _velocity.is_zero_approx() and force.is_zero_approx():
		_velocity = Vector2.ZERO
		set_physics_process(false)
		_status = STATUS_IDLE
		moving_changed.emit(false)

# =============================================================
# ========= Virtual Methods ===================================

# =============================================================
# ========= Private Functions =================================

# =============================================================
# ========= Signal Callbacks ==================================
