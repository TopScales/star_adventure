##
##
@tool
class_name ShipPartHull
extends AdditionComponent

var _sprite: Sprite2D

# =============================================================
# ========= Public Functions ==================================

# =============================================================
# ========= Callbacks =========================================

func _init() -> void:
	_additions = {
		&"HullSprite": {
			AdditionComponent.ADDITION_NODE: _sprite,
			AdditionComponent.ADDITION_PARENT: Body.VISUALS_PATH,
			AdditionComponent.ADDITION_CLASS: &"Sprite2D",
			AdditionComponent.ADDITION_PROP: &"_sprite"
		}
	}

# =============================================================
# ========= Virtual Methods ===================================

# =============================================================
# ========= Private Functions =================================

# =============================================================
# ========= Signal Callbacks ==================================
