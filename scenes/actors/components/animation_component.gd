##
##
@tool
@abstract class_name AnimationComponent
extends AdditionComponent

const NOTIFICATION_ANIMATION_PLAYER_READY: StringName = &"animation_player_ready"

@export var animations: Array[StringName] = []
@export var wait_notification: bool = true

var _animations_added: bool = false

@onready var _ap: AgentAnimationPlayer = owner.get_node(Agent.ANIMATION_PLAYER_PATH)

# =============================================================
# ========= Public Functions ==================================

# =============================================================
# ========= Callbacks =========================================

# =============================================================
# ========= Virtual Methods ===================================


func _setup_internal() -> void:
	super._setup_internal()
	if not wait_notification:
		__add_animations()


func _finalize_internal() -> void:
	super._finalize_internal()
	__remove_animations()


# =============================================================
# ========= Private Functions =================================


func __add_animations() -> void:
	if not _animations_added:
		for anim_name in animations:
			var animation: Animation = _ap.add_animation(anim_name)
			var components: Array[StringName] = AdditionComponent.get_addition_owners_names(
				animation, false
			)
			if components.is_empty():
				var a: Array[StringName] = [name]
				animation.set_meta(OWNER_COMPONENTS, a)
			elif not components.has(name):
				components.push_back(name)
		_animations_added = true


func __remove_animations() -> void:
	if _animations_added:
		for anim_name in animations:
			var animation: Animation = _ap.get_animation(anim_name)
			var owners: Array[StringName] = AdditionComponent.get_addition_owners_names(animation)
			owners.erase(name)
			if owners.is_empty():
				_ap.remove_animation(anim_name)
		_animations_added = false


# =============================================================
# ========= Signal Callbacks ==================================


func _on_renamed() -> void:
	for anim_name in animations:
		var animation: Animation = _ap.get_animation(anim_name)
		var owners: Array[StringName] = AdditionComponent.get_addition_owners_names(animation)
		for i in owners.size():
			var owner_name: StringName = owners[i]
			if owner_name == _prev_name:
				owners[i] = name
				break
	super._on_renamed()


func _on_entity_notify(what: StringName, cargo: Variant) -> void:
	if what == NOTIFICATION_ANIMATION_PLAYER_READY:
		var is_ready: bool = cargo as bool
		if is_ready:
			__add_animations()
		else:
			_animations_added = false
