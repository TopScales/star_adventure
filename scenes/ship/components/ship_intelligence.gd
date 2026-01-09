##
##
@tool
@icon("res://assets/icons/classes/intelligence.svg")
class_name ShipIntelligence
extends Component

signal target_position_changed(target: Vector2)

const _TARGET_POSITION_UPDATE_TOLERANCE: float = 2.0
const _TOL_SQRD: float = _TARGET_POSITION_UPDATE_TOLERANCE * _TARGET_POSITION_UPDATE_TOLERANCE

## Target position with respect to the ship's position.
var target_position: Vector2 = Vector2.ZERO:
	set(value):
		target_position = value

		if target_position.distance_squared_to(_prev_target) > _TOL_SQRD:
			__notify_target_position_changed()

var _prev_target: Vector2 = Vector2.ZERO
#var _driver: ShipDriver

# =============================================================
# ========= Public Functions ==================================

# =============================================================
# ========= Callbacks =========================================


#func _init() -> void:
	#required_components = [ShipDriver]
#
#
#func _physics_process(delta: float) -> void:
	#pass

# =============================================================
# ========= Virtual Methods ===================================


#func _register_required_component(required: Component) -> void:
	#if required is ShipDriver:
		#_driver = required

# =============================================================
# ========= Private Functions =================================

func __notify_target_position_changed() -> void:
	target_position_changed.emit(target_position)
	_prev_target = target_position

# =============================================================
# ========= Signal Callbacks ==================================
