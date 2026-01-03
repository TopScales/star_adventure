##
@tool
@abstract
@icon("res://assets/icons/classes/AdditionComponent.svg")
class_name AdditionComponent
extends Component

const OWNER_COMPONENTS: StringName = &"owner_components"

var _additions: Array[Node] = []
var _prev_name: StringName = &""

# =============================================================
# ========= Public Functions ==================================


static func get_addition_owners_names(addition: Object, complain: bool = true) -> Array[StringName]:
	if not addition.has_meta(OWNER_COMPONENTS):
		if complain:
			printerr(
				(
					"Owner components were not set on component addition %s."
					% Data.get_obj_name(addition)
				)
			)
		return Array([], TYPE_STRING_NAME, "", null)
	var owners: Array[StringName] = addition.get_meta(
		OWNER_COMPONENTS, Array([], TYPE_STRING_NAME, "", null)
	)
	if owners.is_empty() and complain:
		printerr(
			"Found empty list of owner components for addition %s." % Data.get_obj_name(addition)
		)
	return owners


func get_addition(addition_name: StringName) -> Node:
	for addition in _additions:
		if is_instance_valid(addition) and addition.name == addition_name:
			return addition
	return null


func register_addition(addition: Node) -> bool:
	if _register_addition(addition):
		_additions.push_back(addition)
		return true
	return false


# =============================================================
# ========= Callbacks =========================================


func _ready() -> void:
	_prev_name = name
	if not renamed.is_connected(_on_renamed):
		Err.conn(renamed, _on_renamed, CONNECT_PERSIST)


func _enter_tree() -> void:
	await get_tree().process_frame
	if Engine.is_editor_hint() and is_inside_tree() and _additions.is_empty():
		setup()


func _exit_tree() -> void:
	if Engine.is_editor_hint() and owner and is_instance_valid(owner) and not _additions.is_empty():
		var ids: PackedInt64Array = PackedInt64Array()
		Err.try_resize(ids.resize(_additions.size()))
		for i in _additions.size():
			var addition: Node = _additions[i]
			if is_instance_valid(addition):
				ids[i] = addition.get_instance_id()
		AdditionComponent.__remove_additions_in_editor.call_deferred(get_instance_id(), name, ids)


# =============================================================
# ========= Virtual Methods ===================================


func _setup_internal() -> void:
	_add_additions()


func _finalize_internal() -> void:
	__remove_additions()


func _register_addition(_addition: Node) -> bool:
	return false


## Use this function to add the required additions. Additions are nodes that
## are used by this component but are located somewhere else in the node tree,
## normally, as childs of an AdditionContainer.
## To add an addition, use the following boilerplate:
## [codeblock lang=gdscript]
##const addition_name: String = "Addition"
##var _addition: Node # Class variable.
##
##func _add_additions() -> void:
##	var addition_parent: Node
##	if not _addition:
##		_addition = __add_addition(addition_name, Node.new, addition_parent)
## [/codeblock]
func _add_additions() -> void:
	pass


# =============================================================
# ========= Private Functions =================================


static func __remove_additions_in_editor(
	owner_id: int, owner_name: StringName, instances: PackedInt64Array
) -> void:
	if is_instance_id_valid(owner_id):
		var owner_component: Node = instance_from_id(owner_id)
		if owner_component.is_inside_tree():
			return

	for id in instances:
		if is_instance_id_valid(id):
			var addition: Node = instance_from_id(id)
			if addition.is_inside_tree():
				var components: Array[StringName] = AdditionComponent.get_addition_owners_names(
					addition
				)
				components.erase(owner_name)
				if components.is_empty():
					var parent: Node = addition.get_parent()
					parent.remove_child(addition)
					addition.queue_free()


func __add(addition: Node, parent: Node) -> void:
	# NOTE: Make sure parent doesn't already have the addition before using this
	# function.
	var a: Array[StringName] = [name]
	addition.set_meta(OWNER_COMPONENTS, a)
	parent.add_child(addition)
	addition.owner = owner


func __own(addition: Node) -> void:
	var components: Array[StringName] = AdditionComponent.get_addition_owners_names(addition)
	if not components.has(name):
		components.push_back(name)


func __remove_additions() -> void:
	for addition in _additions:
		var components: Array[StringName] = AdditionComponent.get_addition_owners_names(addition)
		assert(
			not components.is_empty(),
			"Found empty list of owner components for addition %s while removing." % addition.name
		)
		components.erase(name)
		if components.is_empty():
			addition.get_parent().remove_child(addition)
			addition.queue_free()


func __add_addition(
	addition_name: StringName, new_callback: Callable, addition_parent: Node
) -> Node:
	var addition: Node = addition_parent.get_node_or_null(NodePath(addition_name))
	if addition:
		__own(addition)
	else:
		addition = new_callback.call()
		addition.name = addition_name
		__add(addition, addition_parent)
	_additions.push_back(addition)
	return addition


# =============================================================
# ========= Signal Callbacks ==================================


func _on_renamed() -> void:
	for addition in _additions:
		var owners: Array[StringName] = AdditionComponent.get_addition_owners_names(addition)
		for i in owners.size():
			var owner_name: StringName = owners[i]
			if owner_name == _prev_name:
				owners[i] = name
				break
	_prev_name = name
