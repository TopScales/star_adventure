##
## An object that moves and has inertia.
##
## Bodies have an [Entity] to add functionality and a [Driver] applies movement
## to the body.
##
@icon("res://assets/icons/classes/body.svg")
class_name Body
extends Node2D

signal despawned

const ENTITY_PATH: String = "Entity"
const DRIVER_PATH: String = "Driver"
const VISUALS_PATH: String = "Visuals"
const PERCEPTION_PATH: String = "Perception"

## The mass of the body.
@export_range(0.01, 10.0, 0.01, "or_greater") var mass: float = 1.0
## Whether the body should be freed when despwned.
@export var persistent: bool = false

@onready var _entity: Entity = get_node(ENTITY_PATH)
@onready var _driver: Driver = get_node(ENTITY_PATH)

# =============================================================
# ========= Public Functions ==================================

func despawn() -> void:
	despawned.emit()

	if persistent:
		_entity.set_enabled(false)
		stop()
	else:
		queue_free()


func awake() -> void:
	_entity.set_enabled(true)


func stop() -> void:
	_driver.stop()


func add_component(component_scene: PackedScene) -> void:
	_entity.add_component(component_scene)


func get_component(component: GDScript) -> Component:
	return _entity.get_component(component)


func add_component_from_script(component_script: GDScript) -> void:
	_entity.add_component_from_script(component_script)


func has_component(component: GDScript) -> bool:
	return _entity.has_component(component)


func remove_component(component_script: GDScript) -> void:
	_entity.remove_component(component_script)

# =============================================================
# ========= Callbacks =========================================

# =============================================================
# ========= Virtual Methods ===================================

# =============================================================
# ========= Private Functions =================================

# =============================================================
# ========= Signal Callbacks ==================================
