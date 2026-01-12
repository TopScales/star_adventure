##
class_name ShipDriver
extends Driver

@onready var _ship: Ship = owner

# =============================================================
# ========= Public Functions ==================================

# =============================================================
# ========= Callbacks =========================================

# =============================================================
# ========= Virtual Methods ===================================

func _integrate_forces() -> Vector2:
	var fr_force: float = 0.5 * _velocity.length_squared()
	var shape_factor: Vector2 = Vector2(_ship.shape_factor_x, _ship.shape_factor_y)
	var friction: Vector2 = -fr_force * _velocity.normalized() * shape_factor
	return force + friction

# =============================================================
# ========= Private Functions =================================

# =============================================================
# ========= Signal Callbacks ==================================
