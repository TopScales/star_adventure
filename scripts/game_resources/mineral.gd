##
##
class_name Mineral
extends GameResource

enum Origin { ASTEROID, PLANET }

@export var rarity: int = 0
@export var origin: Origin = Origin.ASTEROID
@export var density: float = 1.0
@export var shield: int = 1
@export var color: Color

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
