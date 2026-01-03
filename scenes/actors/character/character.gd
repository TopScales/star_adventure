##
##
##
@tool
@icon("res://assets/icons/classes/Character.svg")
class_name Character
extends Agent

const PERSONA_PATH: String = "Entity/Persona"
const INTELLIGENCE_PATH: String = "Entity/Intelligence"
const SELECTION_PATH: String = "Entity/Selection"
const CONTROLLER_PATH: String = "Controller"
const BEHAVIOR_PATH: String = CONTROLLER_PATH + "/Behavior"
const SKELETON_PATH: String = "Skeleton3D"
const NAV_AGENT_PATH: String = "NavigationAgent"

const PERSONA_PROPS: Array[String] = ["category", "type"]

@onready var movement: CharacterMovement = $Entity/Movement

var _properties: Dictionary[StringName, Node] = {}
#var _anim_dirty: bool = false

# Follow the presentation, abstrctio, control architecture
# Controller changes the visuals. Mediator Design pattern? Mediator con manage interactions
# between child controllers.
# Abstraction is data
# Presentation is the visuals. Strategy Design pattern? Each type of character could
# execute different animations for the same action.

# Characters can notify parent controller so they update their abstractions and presentations. Like
# a faction node or something.

# =============================================================
# ========= Public Functions ==================================

func go_to(point: Vector3) -> void:
	movement.go_to(point)


#func set_navigation_grid(nav_grid: NavigationGrid) -> void:
	#var nav_agent: NavigationGridAgent = get_node(NAV_AGENT_PATH)
	#nav_agent.set_navigation_grid(nav_grid)


func connect_signal_selection_changed(_callback: Callable) -> void:
	pass
	#var selection: CharacterSelection = get_node(SELECTION_PATH)
	#Err.conn(selection.selection_changed, callback)


func disconnect_signal_selection_changed(callback: Callable) -> void:
	var selection: CharacterSelection = get_node(SELECTION_PATH)
	selection.selection_changed.disconnect(callback)


func team_notification() -> void:
	pass


func group_notification() -> void:
	pass


# =============================================================
# ========= Callbacks =========================================

#func _ready() -> void:
	#var persona: Persona = get_node(PERSONA_PATH)
	#persona.properties_changed.connect(notify_property_list_changed)


#func _enter_tree() -> void:
	#__set_properties()


func _set(property: StringName, value: Variant) -> bool:
	if not is_inside_tree():
		await tree_entered
	var node: Node = _properties.get(property)
	if node:
		node.set(property, value)
		return true
	return false


func _get(property: StringName) -> Variant:
	var node: Node = _properties.get(property)
	if node:
		var value: Variant = node.get(property)
		return value
	return null


func _get_property_list() -> Array[Dictionary]:
	var props: Array[Dictionary] = []
	#props.push_back({
		#"name": "Persona",
		#"type": TYPE_NIL,
		#"usage": PROPERTY_USAGE_GROUP
	#})
	#var persona: Persona = get_node(PERSONA_PATH)
	#if persona:
		#props.append_array(Data.get_properties_data(persona, PERSONA_PROPS))
	##props.push_back({
		##"name": "Animation",
		##"type": TYPE_NIL,
		##"usage": PROPERTY_USAGE_GROUP
	##})
	return props


# =============================================================
# ========= Virtual Methods ===================================


# =============================================================
# ========= Private Functions =================================

#func __set_properties() -> void:
	#var persona: Persona = get_node(PERSONA_PATH)
	#if persona:
		#for prop in PERSONA_PROPS:
			#_properties[StringName(prop)] = persona


#func __notify_animations_changed() -> void:
	#notify_property_list_changed()
	#_anim_dirty = false


# =============================================================
# ========= Signal Callbacks ==================================


#func _on_animation_player_animation_libraries_updated() -> void:
	#if not _anim_dirty:
		#__notify_animations_changed.call_deferred()
		#_anim_dirty = true
