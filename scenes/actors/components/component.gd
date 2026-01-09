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
@icon("res://assets/icons/classes/component.svg")
class_name Component
extends Node

enum Status {NOT_READY, RUNNING, DISABLED, FINALIZING}

## Contains a list of required components. This should be set during
## initialization through [method Object._init].
var required_components: Array[GDScript] = []

var _status: Status = Status.NOT_READY

# =============================================================
# ========= Public Functions ==================================

## Returns [code]true[/code] if the module is disabled and [code]false[/code]
## otherwise.
func is_disabled() -> bool:
	return _status == Status.DISABLED


## Initializes and starts running the component. Should only be used by [Entity]
## script.
func setup() -> void:
	if _status != Status.NOT_READY:
		return

	_setup_internal()
	_setup()
	_status = Status.RUNNING


## Disables the component without removing it from the [Entity].
func disable() -> void:
	if _status != Status.RUNNING:
		return

	_disable()
	_status = Status.DISABLED


## Enables the component after being disabled via [method disable].
func enable() -> void:
	if _status != Status.DISABLED:
		return

	_enable()
	_status = Status.RUNNING


## Finalizes the component and then removes it from its owner. Should only be
## used by the [Entity] script.
func finalize() -> void:
	if _status == Status.FINALIZING:
		return

	_status = Status.FINALIZING
	_finalize()
	_finalize_internal()
	get_parent().remove_child(self)
	queue_free()


## Registers a required component needed by this component. Should only be used
## by the [Entity] script.
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


## Used to code a custom initialization for the component.
func _setup() -> void:
	pass


## Only for internal usage. Don't overwrite this function.
func _setup_internal() -> void:
	pass


## Overwrite this function to deactivate any modules related to this component.
func _disable() -> void:
	pass


## Overwrite this function to re-activate any modules related to this component.
func _enable() -> void:
	pass


##  Used to code a custom finalization for the component.
func _finalize() -> void:
	pass


## Only for internal usage. Don't overwrite this function.
func _finalize_internal() -> void:
	pass


## Overwrite this function to save a reference to the components that this
## component requires.
func _register_required_component(_required: Component) -> void:
	pass


# =============================================================
# ========= Private Functions =================================

# =============================================================
# ========= Signal Callbacks ==================================


## Overwrite this function to catch the notifications from other components and
## the parent [Entity].
func _on_entity_notify(_what: StringName, _cargo: Variant) -> void:
	pass
