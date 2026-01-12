##
##
@tool
@icon("res://assets/icons/classes/intelligence.svg")
class_name ShipIntelligence
extends Component

## Direction which the ship wants to move towards.
@export var direction: Vector2 = Vector2i.UP:
	set(value):
		direction = value
		__update_deferred()

## The desired applied strenght in terms of the maximum possible power for the
## ship.
@export_range(0.0, 1.0, 0.01) var strength: float = 0.0:
	set(value):
		strength = value
		__update_deferred()

var _dirty: bool = false

@onready var _ship: Ship = owner

# TODO: Modify direction if colliding with other objects.

# =============================================================
# ========= Public Functions ==================================

# =============================================================
# ========= Callbacks =========================================

# =============================================================
# ========= Virtual Methods ===================================

# =============================================================
# ========= Private Functions =================================


func __update_force() -> void:
	_ship.driver.force = direction * strength * _ship.maximum_thrust
	_dirty = false


func __update_deferred() -> void:
	if not Engine.is_editor_hint() and not _dirty:
		__update_force.call_deferred()
		_dirty = true

# =============================================================
# ========= Signal Callbacks ==================================
