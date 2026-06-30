##
##
@tool
@abstract
class_name ShipPart
extends AdditionComponent

var mass: float = 0.0
var asset_index: int = Data.INVALID_ASSET: set = set_asset_index

var _sprite: Sprite2D

# =============================================================
# ========= Public Functions ==================================

func set_asset_index(index: int) -> void:
	asset_index = index
	var data: Resource = Data.get_collection_item(_get_collection_name(), asset_index)

	if data:
		_load_asset(data)


# =============================================================
# ========= Built-in Functions ================================

func _init() -> void:
	_additions = {
		_get_sprite_name():
		{
			AdditionComponent.ADDITION_NODE: _sprite,
			AdditionComponent.ADDITION_PARENT: Body.VISUALS_PATH,
			AdditionComponent.ADDITION_CLASS: &"Sprite2D",
			AdditionComponent.ADDITION_PROP: &"_sprite"
		}
	}

# =============================================================
# ========= Virtual Methods ===================================

static func _get_sprite_name() -> StringName:
	return &"Sprite"


func _get_collection_name() -> StringName:
	return &""


func _load_asset(_data: Resource) -> void:
	pass


# =============================================================
# ========= Private Functions =================================

# =============================================================
# ========= Signal Callbacks ==================================
