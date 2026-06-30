##
##
@abstract
class_name ShipFrameworkData
extends Resource

@export var framework_params: StringName
@export var texture: String
@export var texture_frame: int = 0
@export_range(0, 10, 1, "or_greater") var num_modules: int = 0
@export var volume: float = 0.0
@export var shape: Shape2D

var params: ShipFrameworkParams

# =============================================================
# ========= Public Functions ==================================

# =============================================================
# ========= Built-in Functions ================================

# =============================================================
# ========= Virtual Methods ===================================

# =============================================================
# ========= Private Functions =================================

# =============================================================
# ========= Signal Callbacks ==================================
