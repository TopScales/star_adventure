##
@tool
class_name VisualComponent
extends Component

@export var visual: PackedScene

var scale_visual: bool = true
var _visual: Node


# =============================================================
# ========= Public Functions ==================================


# =============================================================
# ========= Callbacks =========================================

#func _exit_tree() -> void:
	#if Engine.is_editor_hint() and owner and _visual:
		#VisualComponent.__remove_visual_in_editor.call_deferred(name, _visual.get_instance_id())
#
#
#func _get_property_list() -> Array[Dictionary]:
	#var props : Array[Dictionary] = []
	#if visual:
		#props.push_back({
			#name = "scale_visual",
			#type = TYPE_BOOL,
			#usage = PROPERTY_USAGE_DEFAULT
		#})
	#return props
#
#
## =============================================================
## ========= Virtual Methods ===================================
#
#func _initialize() -> void:
	#__add_visual()
#
#
#func _stop() -> void:
	#__remove_visual()


# =============================================================
# ========= Private Functions =================================

#static func __remove_visual_in_editor(owner_component: String, remove_instance: int) -> void:
	#if is_instance_id_valid(remove_instance):
		#var remove: Node3D = instance_from_id(remove_instance)
		#if remove.is_inside_tree():
			#var visual_parent: AgentVisuals = remove.get_parent()
			#if not remove.has_meta(&"owner_components"):
				#printerr("Owner components were not set on component visual.")
			#var components: PackedStringArray = remove.get_meta(&"owner_components", PackedStringArray())
			#if components.is_empty():
				#printerr("Found empty list of owner components.")
			#components.erase(owner_component)
			#if components.is_empty():
				#visual_parent.remove(remove)
				#remove.queue_free()


#func __add_visual() -> void:
	#if visual:
		#var visuals_node: AgentVisuals = owner.get_node("Visuals")
		#var visual_name: String = visual.get_state().get_node_name(0)
		#_visual = visuals_node.get_node_or_null(visual_name)
		#if _visual:
			#assert(_visual.has_meta(&"owner_components"), "Owner components were not set on component visual.")
			#var components: PackedStringArray = _visual.get_meta(&"owner_components", PackedStringArray())
			#assert(not components.is_empty(), "Found empty list of owner components.")
			#if not components.has(name):
				#components.push_back(name)
		#else:
			#_visual = visual.instantiate()
			#visuals_node.add(_visual, scale_visual)
			#_visual.owner = owner
			#_visual.set_meta(&"owner_components", PackedStringArray([name]))
#
#
#func __remove_visual() -> void:
	#if visual:
		#var visual_node: AgentVisuals = owner.get_node("Visuals")
		#var visual_name: String = visual.get_state().get_node_name(0)
		#var component_visual: Node = visual_node.get_node_or_null(visual_name)
		#if component_visual:
			#assert(component_visual.has_meta(&"owner_components"), "Owner components were not set on component visual.")
			#var components: PackedStringArray = component_visual.get_meta(&"owner_components", PackedStringArray())
			#assert(not components.is_empty(), "Found empty list of owner components.")
			#components.erase(name)
			#if components.is_empty():
				#visual_node.remove(component_visual)
				#component_visual.queue_free()


# =============================================================
# ========= Signal Callbacks ==================================
