##
## A component that adds other nodes to its owner Agent.
##
## AdditionComponents can only be used inside [Agent]s. This type of component
## adds extra nodes, called additions, normally as children of
## an [AdditionsContainer] node. Properties of the additions can be shown in the
## editor as if they were the component's properties.
##
## [br][b]NOTE:[/b] At runtime, don't try to set or access any addition property
## directly from the component. This only works inside the editor and is
## designed exactly to be like so.
##
@tool
@abstract
@icon("res://assets/icons/classes/addition_component.svg")
class_name AdditionComponent
extends Component

const ADDITION_NODE: StringName = &"node"
const ADDITION_PARENT: StringName = &"parent"
const ADDITION_PROP: StringName = &"prop"
const ADDITION_CLASS: StringName = &"class"
const ADDITION_PROP_BLACKLIST: StringName = &"blacklist"
const ADDITION_PROP_WHITELIST: StringName = &"whitelist"
const ADDITION_PROP_CORE_LEVELS: StringName = &"core_levels"
const ADDITION_PROP_SCRIPT_LEVELS: StringName = &"script_levels"
const _OWNER_COMPONENTS_META: StringName = &"owner_components"
const _MODULE: String = "AdditionComponent"

## Set this value in [method _init]. Key is the name of the addition. The value
## is a dictionary with the following entries:[br]
## - [code]&"node"[/code]: The addition [Node][br]
## - [code]&"parent"[/code]: String containing the name of the parent node.[br]
## - [code]&"prop"[/code]: StringName of the property[br]
## - [code]&"class"[/code]: Class of the addition (StringName)
var _additions: Dictionary[StringName, Dictionary] = {}

## Set this value in [method _init]. Key is the name of the addition. The value
## can be one of:[br]
## - [code]bool[/code]: Set to [code]false[/code] to not show the properties of
##   this addition in the components properties. If [code]true[/code],
##   properties will be shown in the default way.[br]
## - [code]PackedStringArray[/code]: List of properties to be displayed.[br]
## - [code]Dictionary[/code]: A dictionary with with the following entries (all
##   being optional):[br]
##   ** [code]&"blacklist": PackedStringArray[/code]: List of properties to
##      exclude.[br]
##   ** [code]&"whitelist": PackedStringArray[/code]: List of properties to
##      include. Overwrites blacklist.[br]
##   ** [code]&"core_levels"[/code]: The number of levels in the built-in class
##      inheritance hierarchy to be included in the displayed properties.[br]
##   ** [code]&"script_levels"[/code]: The number of levels in the script class
##      inheritance hierarchy to be included in the displayed properties.[br]
## If an addition is not included in this dictionary, the default options will
## be used. By default, all the properties of the first levels are shown, for
## both, the built-in class, and the script class (if a script is present).
var _additions_props: Dictionary[StringName, Variant] = {}

var _props_map: Dictionary[StringName, Node] = {}
var _prev_name: StringName = &""

# =============================================================
# ========= Public Functions ==================================


## Returns the names of the owners of an addition. If [param complain] is
## [code]true[/code], an error is printed if the addition does not contains
## its owners in its meta-data or the owners list is empty.
static func get_addition_owners_names(addition: Object, complain: bool = true) -> Array[StringName]:
	if not addition.has_meta(_OWNER_COMPONENTS_META):
		if complain:
			printerr(
				(
					"Owner components were not set on component addition %s."
					% Data.get_obj_name(addition)
				)
			)
		return Array([], TYPE_STRING_NAME, "", null)

	var owners: Array[StringName] = addition.get_meta(
		_OWNER_COMPONENTS_META, Array([], TYPE_STRING_NAME, "", null)
	)

	if owners.is_empty() and complain:
		Log.error(
			"Found empty list of owner components for addition %s." % Data.get_obj_name(addition),
			_MODULE
		)

	return owners


## Returns the addition owned by this component with the name
## [param addition_name].
func get_addition(addition_name: StringName) -> Node:
	var info: Dictionary = _additions.get(addition_name, {})

	if not info.is_empty():
		var addition: Node = info.get(ADDITION_NODE, null)
		if addition and is_instance_valid(addition):
			return addition

	return null


## Registers an addition that should have this component as owner. Normally
## called by an [AdditionsContainer].
func register_addition(addition: Node) -> bool:
	var info: Dictionary = _additions.get(addition.name, {})

	if not info.is_empty():
		info[ADDITION_NODE] = addition
		set(info[ADDITION_PROP], addition)
		return true

	return false

# =============================================================
# ========= Callbacks =========================================


func _ready() -> void:
	_prev_name = name
	if not renamed.is_connected(_on_renamed):
		Err.conn(renamed, _on_renamed, CONNECT_PERSIST, _MODULE)


func _enter_tree() -> void:
	if Engine.is_editor_hint():
		await get_tree().process_frame
		if is_inside_tree() and _status == Status.UNKOWN:
			setup()


func _exit_tree() -> void:
	if Engine.is_editor_hint() and owner and is_instance_valid(owner) and _status != Status.UNKOWN:
		var ids: PackedInt64Array = PackedInt64Array()
		Err.try_resize(ids.resize(_additions.size()), _MODULE)
		var index: int = 0

		for addition_name in _additions:
			var addition: Node = _additions[addition_name][ADDITION_NODE]
			if is_instance_valid(addition):
				ids[index] = addition.get_instance_id()
				index += 1

		Err.try_resize(ids.resize(index), _MODULE)
		AdditionComponent.__remove_additions_in_editor.call_deferred(get_instance_id(), name, ids)


func _set(property: StringName, value: Variant) -> bool:
	var addition: Node = _props_map.get(property, null)

	if addition:
		addition.set(property, value)
		return true

	return false


func _get(property: StringName) -> Variant:
	var addition: Node = _props_map.get(property, null)

	if addition:
		return addition.get(property)

	return null


func _get_property_list() -> Array[Dictionary]:
	var props: Array[Dictionary]
	var usage: int = PROPERTY_USAGE_EDITOR
	_props_map.clear()

	for addition_name in _additions:
		var addition: Node = _additions[addition_name][ADDITION_NODE]
		var filter_list: PackedStringArray = []
		var is_blacklist: bool = false
		var core_level: int = 1
		var script_level: int = 1
		var addition_props_info: Variant = _additions_props.get(addition_name, true)
		var show: bool = true

		match typeof(addition_props_info):
			TYPE_BOOL:
				show = addition_props_info
			TYPE_PACKED_STRING_ARRAY:
				filter_list = addition_props_info
			TYPE_DICTIONARY:
				var info: Dictionary = addition_props_info as Dictionary
				filter_list = info.get(ADDITION_PROP_BLACKLIST, [])
				is_blacklist = not filter_list.is_empty()
				core_level = info.get(ADDITION_PROP_CORE_LEVELS, 1)
				script_level = info.get(ADDITION_PROP_SCRIPT_LEVELS, 1)
				var white_list: PackedStringArray = info.get(ADDITION_PROP_WHITELIST, [])

				if not white_list.is_empty():
					filter_list = white_list
					is_blacklist = false
			_:
				Log.error("Incorrect addition properties display information for addition %s" % addition_name, _MODULE)
				show = false

		if show:
			props.push_back({
				"name": addition_name,
				"type": TYPE_NIL,
				"usage": PROPERTY_USAGE_CATEGORY
			})
			var addition_props: Array[Dictionary] = Data.get_properties_info(addition, usage, filter_list, is_blacklist, core_level, script_level)
			props.append_array(addition_props)

			for prop in addition_props:
				var prop_type: int = prop["type"]

				if prop_type != TYPE_NIL:
					_props_map[StringName(prop["name"])] = addition

	return props

# =============================================================
# ========= Virtual Methods ===================================


func _setup_internal() -> void:
	for addition_name in _additions:
		__add_addition(addition_name)


func _finalize_internal() -> void:
	__remove_additions()


# =============================================================
# ========= Private Functions =================================


static func __remove_additions_in_editor(
	owner_id: int, owner_name: StringName, instances: PackedInt64Array
) -> void:
	if is_instance_id_valid(owner_id):
		var owner_component: Node = instance_from_id(owner_id)
		if owner_component.is_inside_tree():
			return
#
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
	addition.set_meta(_OWNER_COMPONENTS_META, a)
	parent.add_child(addition)
	addition.owner = owner


func __own(addition: Node) -> void:
	var components: Array[StringName] = AdditionComponent.get_addition_owners_names(addition)
	if not components.has(name):
		components.push_back(name)


func __remove_additions() -> void:
	for addition_name in _additions:
		var addition: Node = _additions[addition_name][ADDITION_NODE]
		var components: Array[StringName] = AdditionComponent.get_addition_owners_names(addition)
		assert(
			not components.is_empty(),
			"Found empty list of owner components for addition %s while removing." % addition.name
		)
		components.erase(name)

		if components.is_empty():
			addition.get_parent().remove_child(addition)
			addition.queue_free()


func __add_addition(addition_name: String) -> void:
	var addition_info: Dictionary = _additions[addition_name]
	var addition: Node = addition_info[ADDITION_NODE]

	if not addition:
		var addition_parent: Node = owner.get_node(addition_info[ADDITION_PARENT])
		addition = addition_parent.get_node_or_null(NodePath(addition_name))

		if addition:
			__own(addition)
		else:
			var addition_class: StringName = addition_info[ADDITION_CLASS]
			addition = ClassDB.instantiate(addition_class)
			addition.name = addition_name
			addition_info[ADDITION_NODE] = addition
			set(addition_info[ADDITION_PROP], addition)
			__add(addition, addition_parent)

# =============================================================
# ========= Signal Callbacks ==================================


func _on_renamed() -> void:
	for addition_name in _additions:
		var addition: Node = _additions[addition_name][ADDITION_NODE]
		var owners: Array[StringName] = AdditionComponent.get_addition_owners_names(addition)

		for i in owners.size():
			var owner_name: StringName = owners[i]
			if owner_name == _prev_name:
				owners[i] = name
				break

	_prev_name = name
