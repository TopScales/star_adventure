##
@icon("res://assets/icons/classes/ship.svg")
class_name Ship
extends Body

## The maximum thrust force that the ship can apply. Setting this value in the
## editor is not a reliable way of adjusting the thrust, since it should be
## modified by the [Component]s added to the Ship.
@export_range(0.0, 100.0, 0.01, "or_greater") var maximum_thrust: float = 0.0

# =============================================================
# ========= Public Functions ==================================

# =============================================================
# ========= Callbacks =========================================

# =============================================================
# ========= Virtual Methods ===================================

# =============================================================
# ========= Private Functions =================================

# =============================================================
# ========= Signal Callbacks ==================================
