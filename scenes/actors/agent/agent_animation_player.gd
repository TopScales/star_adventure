##
@tool
class_name AgentAnimationPlayer
extends AnimationPlayer

const LIBRARY_NAME: StringName = &"animations"

#const OWNER_COMPONENTS: StringName = &"owner_components"

@export_dir var animations_base_path: String = "":
	set(value):
		animations_base_path = value
		__set_full_path()

#var is_skeleton_ready: bool = false:
	#set(value):
		#if is_skeleton_ready != value:
			#print("Skeleton ready AP ", is_skeleton_ready)
			#is_skeleton_ready = value
			#if is_skeleton_ready:
				#assert(not skeleton_type.is_empty(), "Skeleton type has not been set.")
				#if not _library:
					#__set_library()
				#print("Logic AP continues here")
				#__add_animations()
var _full_path: String = ""
var _suffix: String = ""
var _valid_path: bool = false

#var _pending_animations: Dictionary[StringName, Variant] = {}
var _library: AnimationLibrary

# =============================================================
# ========= Public Functions ==================================

func add_animation(animation_name: StringName) -> Animation:
	if not _library:
		__set_library()

	var animation: Animation = null

	if _library.has_animation(animation_name):
		animation = _library.get_animation(animation_name)
	elif _valid_path:
		animation = __load_animation(animation_name)
		_library.add_animation(animation_name, animation)

	return animation

		#var owners: Array[StringName] = animation.get_meta(OWNER_COMPONENTS, Array([], TYPE_STRING_NAME, "", null))
		#if owners.is_empty():
			#printerr("Found empty list of animation owner components for animation %s." % animation_name)
		#if not owners.has(owner_name):
			#owners.push_back(owner_name)
	#elif skeleton_type != "":
		#var animation: Animation = __load_animation(animation_name)
		#_library.add_animation(animation_name, animation)
		#var owners: Array[StringName] = [owner_name]
		#animation.set_meta(OWNER_COMPONENTS, owners)
	#if is_skeleton_ready:
		#print("Adding anim ", animation_name)
		#if _library.has_animation(animation_name):
			#var animation: Animation = _library.get_animation(animation_name)
			#var owners: Array[StringName] = animation.get_meta(OWNER_COMPONENTS, Array([], TYPE_STRING_NAME, "", null))
			#if owners.is_empty():
				#printerr("Found empty list of animation owner components for animation %s." % animation_name)
			#if not owners.has(owner_name):
				#owners.push_back(owner_name)
		#elif skeleton_type != "":
			#var animation: Animation = __load_animation(animation_name)
			#_library.add_animation(animation_name, animation)
			#var owners: Array[StringName] = [owner_name]
			#animation.set_meta(OWNER_COMPONENTS, owners)
	#elif _pending_animations.has(animation_name):
		#var owners: Array[StringName] = _pending_animations[animation_name]
		#if not owners.has(owner_name):
			#owners.push_back(owner_name)
	#else:
		#var owners: Array[StringName] = [owner_name]
		#_pending_animations[animation_name] = owners


func remove_animation(animation_name: StringName) -> void:
	if not _library:
		__set_library()
	prints("Removing animation", animation_name, _library.has_animation(animation_name))

	_library.remove_animation(animation_name)


func clear_animations() -> void:
	current_animation = &""
	set_path_suffix("")

	if _library:
		remove_animation_library(LIBRARY_NAME)
		_library = null


func set_path_suffix(suffix: String) -> void:
	_suffix = suffix
	__set_full_path()


func invalidate_path() -> void:
	_valid_path = false


# =============================================================
# ========= Callbacks =========================================


# =============================================================
# ========= Virtual Methods ===================================


# =============================================================
# ========= Private Functions =================================

func __set_library() -> void:
	if has_animation_library(LIBRARY_NAME):
		_library = get_animation_library(LIBRARY_NAME)
	else:
		_library = AnimationLibrary.new()
		add_animation_library(LIBRARY_NAME, _library)


#func __add_animations() -> void:
	#if skeleton_type != "":
		#print("add_animations")
		#for anim_name in _pending_animations:
			#print("Adding anim def ", anim_name)
			#var animation: Animation = __load_animation(anim_name)
			#_library.add_animation(anim_name, animation)
			#var owners: Array[StringName] = _pending_animations[anim_name]
			#animation.set_meta(OWNER_COMPONENTS, owners)
	#_pending_animations.clear()


func __load_animation(animation_name: String) -> Animation:
	var animation: Animation = load(_full_path.path_join(animation_name + ".anim"))
	return animation


func __set_full_path() -> void:
	_full_path = animations_base_path.path_join(_suffix)
	_valid_path = DirAccess.dir_exists_absolute(_full_path)


# =============================================================
# ========= Signal Callbacks ==================================
