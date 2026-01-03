##
## A modular, reusable unit of logic that performs a specific function inside
## an [Entity]. All Components are child of an Entity.
##
## Components should take care of a single task. Components can also act as data
## containers. Components can depend on other Components. References to other
## Components are provided by its Entity at the registry stage, using the
## [member required_components] array and calling
## [method _add_required_component] for each Component in the array. Overwrite
## this function to manage the dependencies.
##
@tool
@abstract
@icon("res://assets/icons/classes/AdditionComponent.svg")
class_name Component
extends Node

## Contains a list of required components. This should be set during
## initialization through the [method Object._init].
var required_components: Array[GDScript] = []

# =============================================================
# ========= Public Functions ==================================

## At runtime, won't be called for components already in a scene. It will be
## called when the component is added later. It is also called insde the editor.
#func initialize() -> void:
#_initialize_internal()
#_initialize()


func setup() -> void:
	_setup_internal()
	_setup()


func stop() -> void:
	_stop()


func finalize() -> void:
	_finalize()
	_finalize_internal()
	get_parent().remove_child(self)
	queue_free()


func register_required_component(required: Component) -> void:
	_register_required_component(required)


# =============================================================
# ========= Callbacks =========================================


func _ready() -> void:
	var entity: Entity = get_parent()
	if not entity.notify.is_connected(_on_entity_notify):
		Err.conn(entity.notify, _on_entity_notify, CONNECT_PERSIST)


# =============================================================
# ========= Virtual Methods ===================================


func _setup() -> void:
	pass


func _setup_internal() -> void:
	pass


func _stop() -> void:
	pass


func _finalize() -> void:
	pass


func _finalize_internal() -> void:
	pass


func _register_required_component(_required: Component) -> void:
	pass


# =============================================================
# ========= Private Functions =================================

# =============================================================
# ========= Signal Callbacks ==================================


func _on_entity_notify(_what: StringName, _cargo: Variant) -> void:
	pass
