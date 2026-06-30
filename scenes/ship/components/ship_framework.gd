##
##
@tool
@abstract
class_name  ShipFramework
extends ShipPart

var num_modules: int = 0

# =============================================================
# ========= Public Functions ==================================

# =============================================================
# ========= Built-in Functions ================================

# =============================================================
# ========= Virtual Methods ===================================


func _load_asset(data: Resource) -> void:
	var fw_data: ShipFrameworkData = data
	var diffuse_path: String = fw_data.params.texture_directory.path_join(fw_data.texture + ".png")
	var diffuse: Texture2D = load(diffuse_path)
	var normal_path: String = fw_data.params.texture_directory.path_join(fw_data.texture + "_normal.png")
	var normal: Texture2D = load(normal_path)
	var texture: CanvasTexture = CanvasTexture.new()
	texture.diffuse_texture = diffuse
	texture.normal_texture = normal
	_sprite.texture = texture
	var hframes: int = texture.get_width() / fw_data.params.texture_frame_size.x
	var vframes: int = texture.get_height() / fw_data.params.texture_frame_size.y
	_sprite.hframes = hframes
	_sprite.vframes = vframes
	_sprite.frame = fw_data.texture_frame
	num_modules = fw_data.num_modules



# =============================================================
# ========= Private Functions =================================

# =============================================================
# ========= Signal Callbacks ==================================
