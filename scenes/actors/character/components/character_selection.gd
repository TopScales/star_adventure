##
@tool
@icon("res://assets/icons/classes/Selection.svg")
class_name CharacterSelection
extends AdditionComponent

signal selection_changed(selected: bool)

const SELECTION_AREA_NAME: StringName = &"SelectionArea"
const COLLISION_SHAPE_NAME: StringName = &"SelectionCollision"
const DECAL_NAME: StringName = &"SelectionDecal"

@export var selected: bool = false:
	set(value):
		if value != selected:
			selected = value
			if _selection_decal:
				_selection_decal.visible = selected
			selection_changed.emit(selected)

var _selection_area: Area3D
var _selection_decal: Decal

# =============================================================
# ========= Public Functions ==================================

# =============================================================
# ========= Callbacks =========================================

# =============================================================
# ========= Virtual Methods ===================================


func _setup() -> void:
	if not _selection_area.mouse_entered.is_connected(_on_selection_area_mouse_entered):
		_selection_area.mouse_entered.connect(_on_selection_area_mouse_entered, CONNECT_PERSIST)
		_selection_area.mouse_exited.connect(_on_selection_area_mouse_exited, CONNECT_PERSIST)
		_selection_area.input_event.connect(_on_selection_area_input_event, CONNECT_PERSIST)


func _add_additions() -> void:
	if not _selection_area:
		_selection_area = __add_addition(
			SELECTION_AREA_NAME, Area3D.new, owner.get_node(Character.PERCEPTION_PATH)
		)
		var collision: CollisionShape3D = CollisionShape3D.new()
		collision.name = COLLISION_SHAPE_NAME
		_selection_area.add_child(collision)
		collision.owner = owner
		collision.translate(Vector3(0, 1.0, 0))
		var shape: CylinderShape3D = CylinderShape3D.new()
		collision.shape = shape
	if not _selection_decal:
		_selection_decal = __add_addition(
			DECAL_NAME, Decal.new, owner.get_node(Character.VISUALS_PATH)
		)
		_selection_decal.size = Vector3(1, 1, 1)
		_selection_decal.texture_albedo = load("res://assets/textures/characters/selection.svg")
		_selection_decal.cull_mask = 1
		_selection_decal.hide()


func _register_addition(addition: Node) -> bool:
	if addition is Area3D:
		_selection_area = addition
		return true
	elif addition is Decal:
		_selection_decal = addition
		return true
	return false


# =============================================================
# ========= Private Functions =================================

# =============================================================
# ========= Signal Callbacks ==================================


func _on_selection_area_mouse_entered() -> void:
	pass
	# TODO: Add highlight.


func _on_selection_area_mouse_exited() -> void:
	pass
	# TODO: Remove highlight.


func _on_selection_area_input_event(
	_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int
) -> void:
	if event.is_action_pressed("main_click"):
		if Input.is_key_pressed(KEY_CTRL):
			selected = not selected
		else:
			selected = true
