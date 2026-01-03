##
## A game element that can interact and modify the world.
##
## An Agent contains an [Entity] that defines its capabilities and behavior
## through [Component]s. Agents have a visual representation that can be seen in
## the world. These elements have a more complex logic than Entities which is
## managed by an [AgenController] which is a state machine. An Agent is
## basically an entry point to its [Entity] and the logic that controls it.
##
@icon("res://assets/icons/classes/agent.svg")
class_name Agent
extends Node2D

signal despawned

const ENTITY_PATH: String = "Entity"
const ANIMATION_PLAYER_PATH: String = "AnimationPlayer"
const VISUALS_PATH: String = "Visuals"
const PERCEPTION_PATH: String = "Perception"

@onready var entity: Entity = get_node(ENTITY_PATH)

# =============================================================
# ========= Public Functions ==================================

func despawn() -> void:
	despawned.emit()
	queue_free()


func add_component(component_scene: PackedScene) -> void:
	entity.add_component(component_scene)


func get_component(component: GDScript) -> Component:
	return entity.get_component(component)


func add_component_from_script(component_script: GDScript) -> void:
	entity.add_component_from_script(component_script)


func has_component(component: GDScript) -> bool:
	return entity.has_component(component)


func remove_component(component_script: GDScript) -> void:
	entity.remove_component(component_script)


# =============================================================
# ========= Callbacks =========================================


# =============================================================
# ========= Virtual Methods ===================================


# =============================================================
# ========= Private Functions =================================


# =============================================================
# ========= Signal Callbacks ==================================
