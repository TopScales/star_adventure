##
## A game element with which can be interacted and execute some logic. Entities
## are defined by their [Component]s, which implement the behavior of
## the entity and store its state.
##
## All Entity [Component]s must be direct childs of it. Entity works as an
## interface to access the different components and to communicate between them.
##
@tool
@icon("res://assets/icons/classes/entity.svg")
class_name Entity
extends Node

signal notify(what: StringName, cargo: Variant)

const NOTIFICATION_SETUP_COMPLETED: StringName = &"setup_completed"

var _components: Dictionary[GDScript, Component] = {}
var _cached: Component

# =============================================================
# ========= Public Functions ==================================


func add_component(component_scene: PackedScene) -> void:
	var component: Component = component_scene.instantiate() as Component
	__add_component(component)


func get_component(component: GDScript) -> Component:
	if _cached and is_instance_of(_cached, component):
		return _cached
	return _components.get(component, null)


func add_component_from_script(component_script: GDScript) -> void:
	var component: Component = component_script.new()
	__add_component(component)


func has_component(component: GDScript) -> bool:
	_cached = _components.get(component, null)
	if _cached:
		return true
	else:
		return false


func remove_component(component_script: GDScript) -> void:
	var component: Component = _components.get(component_script, null)
	if component:
		component.finalize()


func set_enabled(enabled: bool) -> void:
	for ichild in get_child_count():
		var component: Component = get_child(ichild) as Component
		if enabled:
			component.enable()
		else:
			component.disable()


func emit_notification(what: StringName, cargo: Variant = null) -> void:
	notify.emit(what, cargo)


# =============================================================
# ========= Callbacks =========================================


func _enter_tree() -> void:
	await get_tree().process_frame
	if is_inside_tree() and _components.is_empty():
		__register_components()
		emit_notification(NOTIFICATION_SETUP_COMPLETED)


func _exit_tree() -> void:
	for component_script in _components:
		var component: Component = _components[component_script]
		component.disable()
	_components.clear()


# =============================================================
# ========= Virtual Methods ===================================

# =============================================================
# ========= Private Functions =================================


func __add_component(component: Component) -> void:
	if __component_fulfill_requirements(component):
		add_child(component)
		component.owner = owner
		if is_inside_tree():
			component.setup()
	else:
		print(
			(
				"WARNING: Component %s not added to entity %s because doesn't fulfill the requirements."
				% [component.name, name]
			)
		)


func __register_components() -> void:
	for i in get_child_count():
		var component: Component = get_child(i) as Component
		assert(
			__component_fulfill_requirements(component),
			(
				"Component %s doesn't fulfill the requirements to be added to entity %s."
				% [component.name, name]
			)
		)
		var component_script: GDScript = component.get_script()
		if OS.is_debug_build() and _components.has(component_script):
			printerr("Duplicated script in entity %s." % component.name)
		_components[component_script] = component
		component.setup()


func __component_fulfill_requirements(component: Component) -> bool:
	for requirement in component.required_components:
		var required_component: Component = _components.get(requirement, null)
		if required_component:
			component.register_required_component(required_component)
		else:
			return false
	return true

# =============================================================
# ========= Signal Callbacks ==================================
