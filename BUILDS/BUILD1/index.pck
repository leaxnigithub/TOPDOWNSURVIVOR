GDPC                                                                                         `   res://.godot/exported/133200997/export-19246414aa9fb561ced4b8dce477acec-default_bus_layout.res  �     `      �0�k��o�k��#~k�    T   res://.godot/exported/133200997/export-1dfc2c274347e11dc35451b9b61eaa50-area_2d.scn �     '      ���N_����٤�<�*    T   res://.godot/exported/133200997/export-362256a061aa8890e9a1e558b11e5ec3-node_2d.scn  �     N]      ��D�ê�$j�ȻHܑ    T   res://.godot/exported/133200997/export-7936cb3314e92baa208a95fc6f151298-node_2d.scn �P     L]      x4��}צ.���L�    P   res://.godot/exported/133200997/export-bdd9c6d2500d8463edc5602402e719bf-dash.scnN     �      U��q/%�+�s��Y�:    P   res://.godot/exported/133200997/export-d9412acfc29a579e2cb27840aeb3088c-dash.scn�     �      ��/o�k`%�p����Z    ,   res://.godot/global_script_class_cache.cfg  ,            ��Р�8���8~$}P�    D   res://.godot/imported/bow.png-6ceff24b0b7a2208273680cdd27cbe0f.ctex 0J      z�      �5py<"�	Z6�(}�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex@�           ：Qt�E�cO���    T   res://.godot/imported/spritesheet_50x50.png-10631733a47c34275bccc35764732a7a.ctex   p�      D      �`��J�3�H*$&�*E    \   res://.godot/imported/spritesheet_50x50_fixed (1).png-9b3f8e08b9c75b9b309b05ed405797a6.ctex P     �4      ĆDX����f;�       res://.godot/uid_cache.bin  �/     k      ���`iV:�G'ɠ�k       res://Area2D.gd  �     �      �>$���!�
�t�       res://CharacterBody2D.gd�     ]      �#a/�X7y�QW�+�    (   res://addons/AS2P/InspectorConvertor.gd         �
      O>�R�(��4vޖ��    ,   res://addons/AS2P/NodeSelectorProperty.gd          �      �UϸOL	t�݊#]       res://addons/AS2P/plugin.gd �!      �      ����) {��1l��       res://area_2d.tscn.remapP*     d       �
�4�(�$v���C��    P   res://assets/698-6986985_pixel-arrow-png-picture-arrow-pixel-png-transparent.pngP$      �%      d������uhn[�fH�       res://assets/bow.png.import ��      �       ���`-���¸����[u    ,   res://assets/spritesheet_50x50.png.import   �     �       �"�	#_@�m�h�    4   res://assets/spritesheet_50x50_fixed (1).png.import 0M     �       SE�)E^;�/TME�M       res://dash.gd   p�     n      	�~�b{��5�x����       res://dash.tscn.remap   �*     a       '��N�O������3���    $   res://default_bus_layout.tres.remap 0+     o       ʦ��͜&}����3]^       res://icon.svg  0,     �      k����X3Y���f       res://icon.svg.import   `�     �       @?�O)ꁉ��V}��       res://node_2d.tscn.remap�+     d       s�OR��0*�FC       res://project.binary`1     v      ���� N�=ͯ       res://scenes/dash.tscn.remapp)     a       ���4)Xmq'����	        res://scenes/node_2d.tscn.remap �)     d       Z" ��Ď�4p�ٿ|    @tool
extends EditorInspectorPlugin

const NodeSelectorProperty = preload("./NodeSelectorProperty.gd")

var node_selector: NodeSelectorProperty

# Properties
var anim_player: AnimationPlayer

# Signals
signal animation_updated(animation_player: AnimationPlayer)

func _can_handle(object):
	if object is AnimationPlayer:
		anim_player = object

		return true
	return false

## Create UI here
func _parse_end(object: Object):
	var header = CustomEditorInspectorCategory.new("Import AnimatedSprite2D/3D")

	# AnimatedSprite2D Node selector
	node_selector = NodeSelectorProperty.new(anim_player)
	node_selector.label = "AnimatedSprite2D/3D Node"

	node_selector.animation_updated.connect(
		_on_animation_updated,
		CONNECT_DEFERRED
		)


	# Import button
	var button := Button.new()
	button.text = "Import"
	button.get_minimum_size().y = 26
	button.button_down.connect(node_selector.convert_sprites)

	var buttonstyle = StyleBoxFlat.new()
	buttonstyle.bg_color = Color8(32, 37, 49)
	button.set("custom_styles/normal", buttonstyle)

	var container = VBoxContainer.new()
	container.add_spacer(true)

	container.add_child(header)
	container.add_child(node_selector)
	container.add_spacer(false)
	container.add_child(button)

	add_custom_control(container)


func _on_animation_updated():
	emit_signal("animation_updated", anim_player)

# Child class
class CustomEditorInspectorCategory extends Control:
	var title: String = ""
	var icon: Texture2D = null

	func _init(p_title: String, p_icon: Texture2D = null):
		title = p_title
		icon = p_icon

		tooltip_text = "AnimatedSprite to AnimationPlayer Plugin"

	func _get_minimum_size() -> Vector2:
		var font := get_theme_font(&"bold", &"EditorFonts");
		var font_size := get_theme_font_size(&"bold_size", &"EditorFonts");

		var ms: Vector2
		ms.y = font.get_height(font_size);
		if icon:
			ms.y = max(icon.get_height(), ms.y);

		ms.y += get_theme_constant(&"v_separation", &"Tree");

		return ms;

	func _draw() -> void:
		var sb := get_theme_stylebox(&"bg", &"EditorInspectorCategory")
		draw_style_box(sb, Rect2(Vector2.ZERO, size))

		var font := get_theme_font(&"bold", &"EditorFonts")
		var font_size := get_theme_font_size(&"bold_size", &"EditorFonts")

		var hs := get_theme_constant(&"h_separation", &"Tree")

		var w: int = font.get_string_size(title, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x;
		if icon:
			w += hs + icon.get_width();


		var ofs := (get_size().x - w) / 2;

		if icon:
			draw_texture(icon, Vector2(ofs, (get_size().y - icon.get_height()) / 2).floor())
			ofs += hs + icon.get_width()

		var color := get_theme_color(&"font_color", &"Tree")
		draw_string(font, Vector2(ofs, font.get_ascent(font_size) + (get_size().y - font.get_height(font_size)) / 2).floor(), title, HORIZONTAL_ALIGNMENT_LEFT, get_size().x, font_size, color);

           @tool
extends EditorProperty
## @desc Inspector property for selecting the animation node,
##			and handles the animation import process.
##

var anim_player: AnimationPlayer
var drop_down := OptionButton.new()

signal animation_updated()

func get_animatedsprite():
	var root = get_tree().edited_scene_root
	return _get_animated_sprites(root)[drop_down.selected]

func _get_animated_sprites(root: Node) -> Array:
	var asNodes := []

	for child in root.get_children():
		asNodes += _get_animated_sprites(child)

	if root is AnimatedSprite2D or root is AnimatedSprite3D:
		asNodes.append(root)

	return asNodes

func _init(_anim_player):
	anim_player = _anim_player

	drop_down.clip_text = true
	# Add the control as a direct child of EditorProperty node.
	add_child(drop_down)
	# Make sure the control is able to retain the focus.
	add_focusable(drop_down)

	drop_down.clear()

func _ready():
	get_items()


func get_items():
	drop_down.clear()

	var root = get_tree().edited_scene_root
	var anim_sprites := _get_animated_sprites(root)

	for i in range(len(anim_sprites)):
		var anim_sprite = anim_sprites[i]

		drop_down.add_item(anim_player.get_path_to(anim_sprite), i)

func convert_sprites():
	var animated_sprite = get_node(get_animatedsprite().get_path())

	var count := 0
	var updated_count := 0

	var sprite_frames = animated_sprite.sprite_frames

	if not sprite_frames:
		print("[AS2P] Selected AnimatedSprite2D has no frames!")

	for anim in sprite_frames.get_animation_names():
		if anim.is_empty():
			printerr("[AS2P] SpriteFrames on AnimatedSprite2D '%s' has an \
animation named empty string '', it will be ignored" % animated_sprite.name)
			continue

		var updated = add_animation(
				anim_player.get_node(anim_player.root_node).get_path_to(animated_sprite),
				anim,
				sprite_frames
			)

		count += 1

		if updated:
			updated_count += 1

	if count - updated_count > 0:
		print("[AS2P] Added %d animations!" % [count - updated_count])
	if updated_count > 0:
		print("[AS2P] Updated %d animations!" % updated_count)

	emit_signal("animation_updated")

func add_animation(anim_sprite: NodePath, anim: String, sprite_frames: SpriteFrames):
	var frame_count = sprite_frames.get_frame_count(anim)
	var fps = sprite_frames.get_animation_speed(anim)
	var looping = sprite_frames.get_animation_loop(anim)
	# Determine the total animation duration in seconds. First sum the duration
	# of each frame, then divide duration by FPS to get the length in seconds.
	var duration: float = 0
	for i in range(frame_count):
		duration += sprite_frames.get_frame_duration(anim, i)
	duration = duration / fps

	# We add the converted animation to the [Global] animation library,
	# which corresponding to the empty string "" key
	var global_animation_library: AnimationLibrary
	if anim_player.has_animation_library(&""):
		# The [Global] animation library already exists, so get it
		# The only reason we check has_animation_library then call
		# get_animation_library instead of just checking if get_animation_library
		# returns null, is that get_animation_library causes an error when no
		# library is found.
		global_animation_library = anim_player.get_animation_library(&"")
	else:
		# The [Global] animation library does not exist yet, so create it
		global_animation_library = AnimationLibrary.new()
		anim_player.add_animation_library(&"", global_animation_library)

	# SpriteFrames allow characters ":" and "[" in animation names, but not
	# Animation Player library, so sanitize the name
	var sanitized_anim_name = anim.replace(":", "_")
	sanitized_anim_name = sanitized_anim_name.replace("[", "_")

	var updated := false
	var animation: Animation = null

	if global_animation_library.has_animation(sanitized_anim_name):
		animation = global_animation_library.get_animation(sanitized_anim_name)

		updated = true
	else:
		animation = Animation.new()
		global_animation_library.add_animation(sanitized_anim_name, animation)

	var spf = 1/fps
	animation.length = duration

	# SpriteFrames only supports linear looping (not ping-pong),
	# so set loop mode to either None or Linear
	animation.loop_mode = Animation.LOOP_LINEAR if looping else Animation.LOOP_NONE

	# Remove existing tracks
	var animation_name_path := "%s:animation" % anim_sprite
	var frame_path := "%s:frame" % anim_sprite

	var anim_track: int = animation.find_track(animation_name_path, Animation.TYPE_VALUE)
	var frame_track: int = animation.find_track(frame_path, Animation.TYPE_VALUE)

	if frame_track >= 0:
		animation.remove_track(anim_track)
	if anim_track >= 0:
		animation.remove_track(frame_track)

	# Add and create tracks

	frame_track = animation.add_track(Animation.TYPE_VALUE, 0)
	anim_track = animation.add_track(Animation.TYPE_VALUE, 1)

	animation.track_set_path(anim_track, animation_name_path)

	# Use the original animation name from SpriteFrames here,
	# since the track expects a SpriteFrames animation key for the AnimatedSprite2D
	animation.track_insert_key(anim_track, 0, anim)

	animation.track_set_path(frame_track, frame_path)

	animation.value_track_set_update_mode(frame_track, Animation.UPDATE_DISCRETE)
	animation.value_track_set_update_mode(anim_track, Animation.UPDATE_DISCRETE)

	# Initialize first sprite key time
	var next_key_time := 0.0

	for i in range(frame_count):
		# Insert key at next key time
		animation.track_insert_key(frame_track, next_key_time, i)

		# Prepare key time for next sprite by adding duration of current sprite
		# including Frame Duration multiplier
		var frame_duration_multiplier = sprite_frames.get_frame_duration(anim, i)
		next_key_time += frame_duration_multiplier * spf

	global_animation_library.add_animation(sanitized_anim_name, animation)

	return updated

func get_tooltip_text():
	return "AnimationSprite node to import frames from."
  @tool
extends EditorPlugin

const Convertor = preload("res://addons/AS2P/InspectorConvertor.gd")

var plugin: Convertor

func _enter_tree():
	plugin = Convertor.new()
	plugin.animation_updated.connect(_refresh, CONNECT_DEFERRED)
	add_inspector_plugin(plugin)

func _refresh(anim_player):
	var interface = get_editor_interface()

	# Hacky way to force the editor to deselect and reselect
	#	the animation panel, as the panel won't update until then
	interface.inspect_object(interface.get_edited_scene_root())
	interface.get_selection().clear()
	await get_tree().create_timer(0.05).timeout
	interface.inspect_object(anim_player)

func _exit_tree():
	remove_inspector_plugin(plugin)

      ���� JFIF      �� C �� C�� @ " ��           	
�� �   } !1AQa"q2���#B��R��$3br�	
%&'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz���������������������������������������������������������������������������        	
�� �  w !1AQaq"2�B����	#3R�br�
$4�%�&'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz��������������������������������������������������������������������������   ? ��9<�������?������t� �>��4d����Q@��3FO���% �>��4d����Q@��3FO���% �>��4d����Q@��3FO���% �>��4d����R1±@$~���3FO����F�� D�k��MJ�ڻ@Hm�� �?�?g&�WG�o�e�j�bI�I'����ڿ�,��O�
�x|I�%�Z|o��$�6����ω�N�e��/����Kෆ��T���O�5��F��-N�=��t�z�Z�qkk, ܖO���>��4�P����ѓ�3IE .O���>��4�P����ѓ�3IE .O���>��4�P����ѓ�3IE .O���('#��w>��U�>��� �O�� :JV�~���PEPEPEPEPEPEP�|W���eπ����~8~�_>��T�"���ϊ�>�=׵{��:n�H�o�t�B�H�P�u�(-䳒����&i�gH�����OR����T��9�P�H�� 	�$��-� �� �H�go�2O���� _�B}�� y����o�&� �:�U��-� `��2x'�/&�hf��E42��������G"2�:���2�5���� �&~�?�P/��?n�~:���뿲_���'�ڧ�Z� ����Y����c��t��^5����G�z���M¾'���ZjSk7�G�5�J��[=#P���3t/����
ӿ���J?���Eo���>υ_��� iJ ��� ���=���co�I߂���W�?~$|;���'��3�o���~4?|>�F��?�'Kԯ4mLi^$������'N����*�Z^Lm5++��.��h�� ��n� ��/�A� �a� _?�w��_�� ����( ��( ��( ��( ��( �^��?�%*�Q�� n���%+u?S��( ��( ��( ��( ��( ��( ��(��?����I��� fI���^���O���/��{� ���/���̓����~?���}�_�(��t-n?�=00?�Z�� .�� �_ɗ�w�������KM��G��	-��i�6��������C� �.�� `�?� I!��� �,� �[�� ���[� �C����#���� �`��� ���|��������+�n� ��/�A� �a� _?�w��_�� ����( ��( ��( ��( ��( �^��?�%*�Q�� n���%+u?S��( ��( ��( ��( ��( ��(��������$o��s����-���'�$������x�@�W���@��ҵ�>Xo,�� D�u-.顑L�7�6��u?�� �� ��� �C� k��=�5� ��g��� (I��� ��K� ZW��� ���[�k�G���/�����
]���_�GƯ�Ӿ$�E�ߊ?���e�s���_��+�I�3�Z/�<[��XxZ��^6�w�mtx&K8uok���v��� ��`�?��� � ��R������9� ��V� �����)��_�k�LxO࿏�O�X���������V��|���Ǉm5��<-�=z�-��|7�X,3�Ev�i�۬/�� M_���K���������P�DZ}�1�V�GH��F��(TEP0T  ����߲����Ux2����%�O��i^#��~��/��Ҽ[�X��Nӵm"�_��uk{�hu[M/^�l �DGk��¬�@1�#o�"�����#>1��"6� �)���7� �3�� ;� ���r��K���� � ��G� *���?��?�W� �� ���ҿ��/�A�Y��eτ�����/��4�~|*�+���'�� �>4ox7×6Z>��'����Q�l�[Fuk���q���i��� �����_�~� � ����� ���g���>	~�� �V�ڣ����<��P�;��>'��q�Yk:v��7��gO���Ž��4�#V��7ľ�4�~է���X�,m��4��� �� ��� �M�#�Ba/��<���jx��G����xS��_�h>'��5�'D����:�Q{{�'Y�/�4�F���;���9����@� �X� �N����}��7��� ����� QE QE QE QE R�Q�Β�z���t 7S�?Β�����t� QE QE QE QE QE�[� +� �n?��� ֕�5_�C_���|~��� ����?�d?�~*�?�<���V�ϊ<�T�%ғ�>��7�[��4��Z��-,n~�g0w7 ��_�G� ���� ��?j��K� �E ����?���G� Gi�S� ��_�b)�g��H��?j~?���� �� � 7�+����	m���������KE�̕Ge�I$ N �_� �6����������O�>8����:F��]��:��`�C�3_�^(�f���W������ķ3HR�η�l��b��?�|��,�.��*c���Nyn.�%VI��Rt� �~��Zz_��x�,��3^.��Zq�a�J4Օ�#7)?yh��?�+� �/؏������ �?����Q� Y~��v��?��%� �"�R> �� ��?��'7��o�� �� ����&����5�~������_���%����?�/�_�]��`�&��|0��m+I�O�}���z�����Y\�݋Y�6�E0G_�.�
(��
(��
(��
(��
U�>���R�Q�΀�~���R�S�?Β�
(��
(��
(��
(��
(��
(��
F�~��R�7C�?ʀ?�7R� ����}��ׯ�?� O��W�����e� ��E~&j_��� ������g� 	� ����������b|(�����8�)� c�_�MS���?�]/�*���QE���ȁEPEPEPEPEPJ�G�:JU�>��� �O�� :JV�~���PEPEPEPEPEPEPH��� *ZF�~��P���_��� ������g� 	� ����������b|(���K�B���q� �^�l� ��?�y^>� �s���O��tx]� '�?�sK� I�]��������� �S?�
(���s�(�� (�� (�� (�� (�� )W����IJ�G�: ����IJ�O�� :J (�� (�� (�� (�� (�� (�� )���KH��� * � 4�K�B���q� �^�l� ��?�y^>� �s���O�����B����?�k���'�O+���n~2� Չ�Ώ���p���i�5O�6� �?<� �t���g�EW�."Q@Q@Q@Q@Q@*�Q��)W����@u?S��)[����I@Q@Q@Q@Q@Q@Q@#t?C��i���@曩�B����?�k���'�O+���n~2� Չ�5/�_�����z��� �� ��x�����_��>W���w��n� ��/�&��w���G��.���L��(��� E��@��( ��( ��( ��( ��( �^��?�%*�Q�� n���%+u?S��( ��( ��( ��( ��( ��( ��( �n���-#t?C����u/�_�����z��� �� ��x�����_��>W�f�� !����� ѯ_��@��<�ٹ��� V'� :<.� ���9�� ��?����H������ ҩ��Q_���QE QE QE QE QE ��}G�^��?� ��O�n���% QE QE QE QE QE QE ����n��� �n�� !����� ѯ_��@��<�ٹ��� V'�LԿ�!}� _w�5����� '����7?���Q_�G���q�S��4��������غ_�U3� ��+�?��(��(��(��(��(��z���t���}G�����t����O��(��(��(��(��(��(�����T������MԿ�!}� _w�5����� '����7?���Q_�����/����� F�~�� ���}� f��/�X�
+����N7
����T���o�#���K� J�`QE��� QE QE QE QE QE R�Q�Β�z���t 7S�?Β�����t� QE QE QE QE QE QE R7C�?ʖ����T�i����/����� F�~�� ���}� f��/�X�
+�3R� ����}��ׯ�?� O��W�����e� ��E����O��� �j��|m� $~y� b��T���(��\�D
(��
(��
(��
(��
(��
U�>���R�Q�΀�~���R�S�?Β�
(��
(��
(��
(��
(��
(��
F�~��W��� �v�m��%��}��o�Ӧ���_��f� �V�e���Mw�:���T���S�7)g}�x��pA��+��CEh�sJ�my1�t�"��(� ����V2:왃������ �ՠ\Կ�!}� _w�5����� '����7?���Q_���K�.�
%��@��08PK���$OZ���s��� �`YG�@~͖�o<w�{��M�E�+�z��4�oE7����O�5� \E��S�2�v��C�^�ֲ<�����w��n� ��/�&��w���G��.���L� M�+��?�0O�+'� �d��3�.� �_�7�s�����}�6g��㝿�m~(�Q���~%���5��d_�q����F���o�mn�Զ��=-�|�N�����<��H"� E��C�&�(��(��(��(��(��z���t���}G�����t����O��(��(��(��(��(��(��H� ���$_����'�?�z�������<��RE�;ْx3� W����A���� �K_���� E�~y�M��xg�ʾ�� �����6��=-������� 6� ���*����6�����8�)� c�_�MS���?�]/�*��I_�w� ��� c��������7��"W��� ��_�� ����h��j������ȇ�Q@Q@Q@Q@Q@*�Q��)W����@u?S��)[����I@Q@Q@Q@Q@Q@#~�߶7�`�G���u�C�~/��~��R�^���Ѯ<Y�'��w� X���5}Hw��<Weyw��V�{���p"�_��#C� �}Ѳ�ؿ�&�-� ς�O���BO��� `_�_�ҿ���h�����c��v_�4_��� �7��g��?|+k�!x��?�L�֕�[�~������#����� �?'��<?�úe���햰�Ɨ�$�LVQ��^��� P�C{��� ����6��_�2��Q��F� ��x�� T7��_ؕ P����DPC|e� Z8�BF���QB�3� pq�@��?k��5�����>i
�ǯٗG�t� �%�����8���E��$�����sr�j�:�b�㘴��� ��+���ȳ\s�����e��':��&�#V)��NR����Տ��<C�l��˱x�,���N�h�F��NќU��ժ�?��� �� ��� ���Ɵ�:��� �r�F>� �d� � ��_
�1� }����_�����Lmn��� g�?j	<B��A��Ҟ_
�|E��<c+i�������������^;}�%��w����
��?���[���f��d߁��������=�ۿ���������?�����|U�����_�^�|C��#�@�u� ��3�|��z�o�]CQ�G��u�k�I�,/�V�)����p���__�� �� ��� �9���do�_� ���� ��( ��( ��( ��( �^��?�%*�Q�� n���%+u?S��( ��( ��( ��( ��( ���Wƿ�T�'����� ����F�O�|�����S�A|.мK�hw�i�΃�h�����+Wү���4��xn�.��	�I� |/� +� �n?��� ֕�5_�C_�� ���e۟�	��Q��߱��#�?����>+�m~����'�;����7>�����^%��oÿ��ߊ�G6��x��z�zN�t�w��-[W�X��S��y����*��#��� �c��� ̍ x��e?��S��� �����o��*�V����٫�������|�I|����z���������?�=��ᛯ�� ��oXi)�t����Uѵm:F�K�2��%3Z̉�R��@��'���	S���Q�؎9bv�H����>���][š���VRFE{/�����%���_}�� �p���g?��:�<=y��K�� �1���l</��V�}����[�z���i�:���i�I*�w8�U�B��t���;��� �oٳ� Y7�e�]�7�m� �� ��||� ��~�>���/�߆)��������_ď�7^m�f�9��di#�� �o��@�Z���hڀ���욞�{c>ˋi�@���%�����	�� g��#�� �_�_�-�� �6� �߳� ���|y���~��	����g��~-|J��+�~|-�q�o�>1�����1��4��~
�W��m[ľ)�.�e�hZ�}�jWv�v�L��� u� �X�E� b��I��?������?���X���+� �h��>	�~� ���_�S�<!��?�I� �?�� ���M[T����� �{]�������������Ǘ�E QE QE QE ��}G�^��?� ��O�n���% QE QE QE QE �,��W��J��[��O��� ճ�� i�� O�+���G�
-� g��I���U }�� ��qa_��p� �e��_�_��� ��qa_��p� �e��_�@5�������� �� ��o� ��ߴ������D���S����3x�����J}c���|:48�|@�n<5/�S�Z�N�m?��b���� ��:�ó��A�w�]�?��(�0��9�� �WQ� ҹ���� �.?�*_� ���*� ��������7����<�wuqrc�Fg��ٻ�n����q��Y����U��$7�M�?�b��|��w��|>���'��Ox�῍�ǈ#�?��鬛����I:5���]�Jb-��?��� ?O��KY� �gi����_����,?n������/�B��_&��/ĸ���>0��� �W��w�J���1���?���c[ �sO�j'N�Zې��U��E�����+��� �|��_�_��� Y� �]� �H��¿k� �gψu�!������o��/�����+�'� �!?�&��f_�����PEPEPEPJ�G�:JU�>��� �O�� :JV�~���PEPEPEPEP_��� y� ��� �E���� i/�[>*�����<[� �� �{�� �!�ǎ� a?��ƾ4�v��x��~/�o���S�~(�?�u��o�}{�:�����WZ�uK���u=J�����in.g�i��}� ����_�W��?��~4W����� ���f���	i�U�ҟ�����U���in~�|����?����ǉ~8�3�o��<�Kᗇ�1�
ͯ�C�^ �.���I�xo]�4;�L��mg� 8� �z�����9�x�]����h�� ��?�%�����|��u�v��B� ���~� �F?bO�� ����o���s�?�7���S�������Ꮗ:w�o��(�����j��t_Xx��~(�����N�C��<I���X����\\G� ���&g�#��� �J�� � ���؟���&g�#��� �J�� ����&g�#��� �J�� � ���_��� (1������� ֲ��_l� î?������_� +�� 0�u_�^ڧ����?�_��������?d��������ٛ����<�0��~��ů��|C�_xa�Q�o���>"mB�:ߊu�o���յ[��?�#�
�� (�� ��م~�� �ϟ��B+���� ����?n�د�Ư�c�����o�� �g�9�/�������� >(|4�� �xS�>!��~2ռ/�_x������xOĚ^����AԵX����.-�� Q��u��3����� �%|� ��?�?�2�rm� ve� �Y_��xO�O�o�f��� �%� �t����� �����R�	<����G��� ����_ۿ�_ۺ��?��ڿ�?�5O�y�~w�PEPEPEPJ�G�:JU�>��� �O�� :Jq'���>��>��4 �R���у�#@	E.���>��4 �R���у�#@	E.���>��4 �R���у�#@�?�\٫�_�� ����g?�����2�I��[�/���xS��3xs��?k)� 	���x[N��|?���]n�.>��KV��{ki��c�!�� ��ђ��������qp}�h��?�������� j� �'��K������?~Ԟ'���x{���=��u�� <5g�� j�2���K_;[�e��{�[����2إ�͜���.���>��4 �R���у�#@	_�g� �� ��Tl��*��7�G�Ϳ���,���(���.�������/�� �g�<B?���ſx���?��ִ��z����l�Οqkw?�&���у�#@���� ����X߂��_�[��o�� ���������3��� �������<	���)�^����|k�u�W�+Bү￳�]3Qկ���i�w��o'������у�#@	E.���>��4 �R���у�#@	E.���>��4 �R���у�#@	J�G�:0}�i@9������        GST2   �  h     ����               �h       B�  RIFF:�  WEBPVP8L-�  /��Y�0jI�6ڟ�?�BD�'�F[��S�%Q�Y��OR�ow+�����6�$��Gw&ܧ��*�$�*�_Ãσ� ��$GR��N~�B=����L	9Q�@�����\J���(f�`�oL@�u��	J�.��	���$� =�va�	vD�L6�� �uH@ �B�Z�v��`�	&��}!HHH	�Q�7[n����T�9*���e���X1�P��C�mz0�:�r[�,zƙ�ębe�9�z-�w]���Vg�#AE���Y�{��-�I�JM��I..�R��T�>{��y��������������紑������҂]�h�ā,����H�p8���gy���zﻘ�����n#4�38m�i��B�T���}k۶m��V���~_ɐ8e�d�i�Nc���Ó~��2��GaO?-f�`!�,Y�6�����/����H���H�	M à(�h�fq��R9�E���nוa�C�X<ȪX�PW�K���.�2����(㊷�N�E�10�P$$!�'!��cQ�l�m�s|�d{�{ �?�bz��  @���r�0�玄�+�����|��~��g`�o�m�
 `(\�{���s7�����_��%� �ڳ�G�7>���>���l��kk< ��!s��N�x;���z��9� >�g�� �s&k<DPߗ�C����~C��YG���wo��=v�����<$p����%��B��p�����!��~d �M�ߘ',��/|d̻_�H�93�<�ܪY�������?t�{~�C5���i����HV��R���o����&t3ܽ�\� O�]}iñ����?�?�n��@7�~�__��7��B����>�q���-?�_���z V�m�G��m�'�kR��k�Cݔ�8�!�����$ �3E��8x����?��w����F�L�Q��	�xH�]<��������}���g,��,�-?����\�b�  8wsQ6��#?�$�h�?�o��\�}����[I�@%gM׾��vw,�=������
�>�Y])��Ol3����j��o��z�������{����� ���t ��i������-�ͫ`���@��Ôwn��k�ʭ*wz����fQ돊+���o����;7������[�� J�A�����J�� �cP�'|-$���]��癷x��zK��W���|<E��ڝ{�޶�JI�\?X4Ԓ#�m���{,}���W����$޸ĝ{�E�D}o��3|��/�A	ϰW��� w���{�zo3zp��p���o~O��B�Q�Ow?�k����]S  $U�κb'_���iT`�߿��w���?���'�c���z���m���	l^Y�ߝ�M�Κj}��~u<�����xPM�/*�}Q��8��j�Ş����Ӈ↑�^���߹��=�/�6�D�����W�T��/��ͯ����~���=*pU�`{	/���������  ;�769�<(i���o~��D����6�2Z`�w�1X��<�E��+��>�&����c T� 6��*��c���������F?\9[u��MVH �37�������䮣Z�~g�H�����Q�P*TR-Y�'L�5~g�x��z�X}OBX����p��#z�f< ��.T  i�斦r�  ���OW���4�ZO2 =���iրf< ���>� �T�3�E� @F�" �J�	�@`���J+���_�3��qO% ��y�g,ݼ��i�`��2  ��E�J� ��,ݼ�b��.���>k}�C H�!�0X�Qn��M堑��f>��dIXzK�Y�G/2�:�#&��'�f��h=�o<iW�����9���$�W� �0,�eh�L3@?̇X� i*��1I�j�US\[��ѱ�im����eB�cA#�}����v����0�fn}0Ӄ�Vm�ڲ�,�/�]Ug���~�f�V�vz�y�di��F���������XUV�ʴL���U��P����|�7�w��A��V�0=oV.w�\��	 pf����V��X��aZ��ݮ\��r�  g����l�-��K5/��V���@�� ��Z ����+����  0n	�.���>�K���"m�j��{��
��ߚ��Ţ��2 0 �Dgz�	^���D���_  gz*�5 l��Z/�3=�f%���g����n)����o;��l)�`& `���V�e���ԧ"2�a��؂����dq��F�!)�4��]i���� CD7@ X��f�x��ԯ����AB�i�D{@�-�}�+_j ��  �B� z��Qz��ṅ����@ ��~!�,tP)Մ���߯)gzC_�W�{��4O���i���5� gϡP�$� � �U�%U�����<�ћ�c�����}��C���g� P�6-
��	��-@�3$MҲ,�,^n�����\�#��Afz0�$d��LI�(��7[�TM�Oo'  �-P@E� 0j$�Q�������d&c��}沣�\֮O����G�%-}�+'{������k7ӧWя���ۻ\	�"� Tk����Zr�������kJ��ݚ�=_��5律�������w|�ֱ^D	 �@�~^��^ J ��\� `���{(�!����GO��z� ��:ү#/�t��~��*k>��Z��k @X (� (ڬ�R  R� e����[���:�2����C�׾Ey��X���W��`�IU� v�S�ל���&�jd�� E��<p������h�u�����#-����2-m�@��-J˦`�	��4�Ëv4�㧘/�hWo=�H����I�W��� �C �f�(t]�����$<����Y��(��~=����Z�E����)�֯=�͖@�"�ٵ��=�@#���KeEn��6o���k���?�vx�ë\5�$�fH!����� =�֯�P��������K��H9�_�TD���+�l>  M��}N�����2���k1  ��?���^�WuNU\=��PIy�V�Vf|b�~h9E^J�li�  O<�_�  mz�b}/�Cˏ��^
�-��<upӡ���Aj�����?�B�����Է�������>����{_ИA�����p����,zq�莗9�O^��c�E�����3��#w�,�� �� ������z�J�9��:�����uEЪ���?�J�p@���^S@+�M������)m�w��E��m�+s�_0
*��A��4�Տ�����H��^�W�gǳ�hT�5b�~h�î]�  Ҩ�	��x�K"���=���M �[$��$����� L)�������>H����� I�o��  -i�!( ����{_�V�� u×~A���h)���騹��L��I7�cY�$�,��ǎ�g�2m�eB��[����_��q����T��V���9�[oY�?�[9�Y�\�r�R|⢚�GZ�N^-�S@��w��*5|�^�Jح����\���|rwɱ� ���h��{�]'�<��o��ga�4>v���D;H���g�����3w������ �����?�F,��o�`PhєPQD���w�m[,&w�=��_���_���ط�S���8L|A����d(K��� w��R�k�M+�a�\��--x(��
I��|�l7��.����D׉,R:D~��`�e�����r%�;{����G�����{��Q��	u�"�C�m. q���8[�5�=�N/�xp��zo��'A��]���٥�Teʕ о��v��2ˁ���mzn��O�����|���:��m]�+�����k��o���nΌ~~���]�5+�`j�A�� PAuy����-e}l��
>�����W $ �	�����n��Y�};�-f2$�J��*g����I��\����oO���&�c�N��D�2\N�}-%s��3XN����Eġp��*�2,�z��(J�|���I��܀_�+%s��g5ܻE����<U@$G����Z��̾�S�T�z�
@%M�O�C1��?�3zz�;�ӭq�>n�`�?��7����]O��(���?����j}[ q����9���D�����݉���g�O/�]���:��E  _z)#�!5��ӌ��w�P��f]t���ׯ߉bV*dI~ Dդ�l�]zg��ӋD(D  D��L�ż(iȑ���'�!��Oؤ2;��j�Mvws�7M���f�1���G\t G�|z6s����ׯo��I:���F�k�Ëi"�����<�tH>\;s�{/��h}����� PR ���Ӯ~��!J���Ҙ�3�� q}��h�WR}��ZRQ-�������+�x����4�6MPr���mͤ����h** E$ IQ%dR%DH �J �41,/�2�S; y� <KR ��ö��E�\�c��I3Ц)�\d��5%G�R��g$G� E�"�U	����E�������	p"�n�+��26v�W�Z�=��_ n���߼��"��3�&X��{4��8������4 ~�O���mf� �Р����wE>�Zy�Υ-p�&�����m-@��I�� �� P
 @)弽�Z1jֶ÷ @g�e�>�R�ܴ{�b��s���1��E� ePe��\���^1j���  蔯�U
�D��ڹ����I)��t�0��5eҶ5 ��~�@泿z~w+|w۷ ������wqrC�<-{km�'d��^4ML�֌Z ���i�\Z+��eL����Nӿ�ͪ.��t��^���$e�D(���nx}vǂ�%�>� Bj��_����-�u5�Ì�=�f&ke!3?��WU�  )" �F_[6�M�j*[������ٺj�4��,@@|,�]��r�k��F\�1�9�ks���nf�l��,.]���D��9����5�4* ��� �F|,u����$�6�22fʹ�k�	Ư?���'�l$3
�$GeHrR���&��jN�.$�%�.%DW�>��-Kҿ�E'���Lٓ��&�?��̓�Q��~wf�t���ńl�H8}� ,��K�^���/�kd�73í�ҕ�n|f�^��`I֗��\�@ZŖh��i���g�H���t�����\�y_; �P�q����_~����ߗ��@��@% �vZ���O�J%ʳ�������S  ��@�oDj�� `Z��Jg.�J���˱�7~���ÿs�^�7�y�@!H)R�KQ�Db����pa��*) �I��$���e��C�$��L��Dr���o|}���{�|b�&��F�B�5Qf|��� E��9:�R� ,�����p�
(��C�������o���mJ@�;CG���e0W�Re]�I��s�}�\���i�����`	_�;K=�;��l�HKsZ	h��K�+�2� ����F  �П,������_S��or���h�f ��G��������Qd����?8
�Y�ΤF�H9�� ��_`��w���N�)�W_�<�샻I~�����U�����<����Ϋ߆��wR �vc9-f&��J����/��ڳ����=䑣��͵�z]���^����]׿���{$L���#�/4�#{E����������R-��'_҃���ec�������a,����_�5 Iԯ���I\L�J����}���h��2�^�k���1�a,d�k��<���7��� H�@�b���O`*1IYg�\��9`�@S�i`� �BxM����/��"Z&� <�h�N���E;ViCA�eI�^m�0h�1^|���5�~^|�x��& ��Ƕ�T��ͺl`#�\�`L,S����������8� �MЦ�j>�� ���pԚ$ X5md��z��>�a-ł�u�l�޷��1p�o�� q�5�~�3ϑ�
��G��ʺ�Jj�Wp���0�<S�� �F�:�K!�����_@<��{D�\�!���ŷ��������7��7o�r�v��ie���.i�z�3d6 �G�zF:��;��O��?�}H� ڴ �����/��׼�Ou��v@��-�!�o]w�;�ט�E��MK=�|��1�L �J���_�� ���B��z�5�|A;0��w^L;�A& fǭ'�v��u�Y��֮�ځi� ���zr��ӷ��v�< yF	f# It��T��A� � �Z_�'-5�o}�5��SA}4 ����^<9  ��}ݤ�� 2Q�%�k�@ �M�.$�F� ���X,��������]0*4�Z����e$ �H���^ h�?��u����]�� ��������Q $�h�����f�`6�����{����?���w��U"���L�UT��F�a2U�J�	0���M����<�\b4������ܦ����g �v�&»@�����߹�3��?���#!�IH?�2�Կ��w��<�����r��>̟�1M~9$HAyT���u��끣�  ` � ��f  $a����ӎ^��n��������l�  A"��0�o	!1�����U]�"�]C= �l� ��Jq5����r�ď�\��r6Mi��w�� AĆ���rr�����F	�՜
h�� �װ  ��s]��P�Ka�wWۭq��>����<��ys����������kؕ�\?.ʤK�AA�3G�	 `.)$��P `������  s�"+_6^Fxp���GO��i����j}�5R��DH��7� �A��O�x��(-{N����*%$ a�  P��s]F�XP5J! R��  ��ꢷ���Y�R�! �O�,�i��i��h� ����5�����, ���ÿ��Ӭ8�4c���d�&�$g_<_��!@�h��"�ӿѤ B����� `k-9��/,��O�|�4��^��  E�� �~�� ��r�q��'9��O�}\�y�������z�ߜ�Zj,�:� ��T/  `����Ƃ���|ϟ��W��[ѪOo�?<~t/��$@�]�'$_��F}�g��̫�@] 90�  J� ����{�>st�5~*l�"z���� ��;�3G���Г���!A4�>�,H>���b �  �34�( T+�	�z{�i��1�Moں&�����?�[)���'Qn�m�,��� �a:L e�j�d	�")���2�m��×"�_fP�cR�� ����ɢ�|I b	IP ����S}�
 ����<�x�@h"� ��r H!�o�ʳ�R��H��!0�����Ol�d�A�ԋ� ��!B�Dك� 6����D@[9� Ym  C�ƺ;zo�D@[���/k�"B�t�F�	�jh��^�cC���T��6� 8�O>�e�n�/������2m����:�\���;d����e�n�/��j���L� ~��!�RR�����r7�>MP�(�H�p"}�5��S�SNVNSL�n���N�@���<-h$���o�Y᧳��k���hc���x���^����'��"�7�*]a�k�畸uYn�����+�273e&W�{�_�[OV�ۿ��I٘�l.s�NY'W��i�WN�4'b���2k��� ���'�����ͧ
T���5S�*{�nIܑXJ�E��~ �����o�/biE�.k���AA�[��}ѷ�ݝd�+�Wѓ��?����  ��P�k�kG��M��  �=��˵��7M֝ W}=$ �Jr&F� �r�*��4�j��T��L�b�=ô{��c���w���t�SC��ش{>�~��v�1�.z{>��C����'^�SȉP�E��������4��_f���7�k#<�zH "J߇��.��8�of�s���T!��H)Zv���3XZGp�߿���?�ʦЩ�������1 @�/DC�~L �AYvg��"	���th `��^���Wu��ɞH>�(���Luؔ��&LWv����
 �Є%~:�18��K<6پ����4�;�ji譧
d��dT/tB��(�6Y�J�N�  l��l�1�Ӎ�+'{��F�>�p�S��(�b>�`� Qաi=(q5|����-~ʃ��>���*��ſy|���*ѓ�~i��y�\
� 12FS��xX��h���ä�|MM��f�C�\W}�T ���&F�)_rj%|��Ϩ<�|bdʓS���թ'�~��V1B����e6�s�������}��|��T�Ny��6��_��C�	 @��e�>\&���m���C�%��Kw����NO� l5�_�_�Bi�l�3��xx��7��o��7�n_o=�՛�o�r�g�]F
 �#� ��[W�^���)c��^�W��L����Ӧ7�빛�o�z/���j�����
Oo=U vG;�b�-��=p�	����O}�x� �i���S����/���D��ͮ0�P�����~L<�����r�Y�� R�� <�U-}��^�f��7�D�o��=DoB�n�Ӌ�B�k/m�|��g��I(�zI� L�������K� �i�Ѓ���W���VO��<��O�?�k�W�y�Mh��pw^?����l��-�����YF0�޲֯������|����o�:^����z1UH 0r�.�k��
���L)%`�����y�ƗIɧ[F������M�/���������> �y��~��z�$�/ �P
`�i@�y��c�Lؾ� ��|�^/���G��K�y?2 ��UKB� ���vSm��{'>��٣ ����˄��[��>�}����}oB8~� `?U$��Z�G	�$��� ������zO�����a�S�J���8<���  ���go�Y�^� �� ��/��@�s�SCo<U @�7�P  sr��T�Wp�p:w81��/����N�A�� ��y�q��\ ��>w�p�x���kǌ�L��G�z8�;�f!X�!BI^\�]\������q��d���@ �z8k �nJ-�Ƶ}ћn�՛���-�o,'lv{��e?�՛�՛�&��n��?�\� O]?aR����c4�A6�3�3xj{�0���]��7�΅�Ѓ��y�y����'�Ed1u�ԣ���g��͓ݮ����\��.��Ai���|gHH?X���O�|V������vu���{���� <j�_� �_{pV		T�Y��-'~����Pnt�����
�-�������K���w���[S�ӿ�ǵl�l^�TzMo�=����{�l� ����@%gM׾��6c��Z�`��;�y�g�Q�V�;�q|���ҿ���VH��F�x���+go��w1��*w�]�4>~v�ىw`o���xz���/.^�EQ`�x�&���|��?\���{$��˸��_��\?���q��~����cF�?\�չ5��C��//}ަ7?�g�B�7��l�/o�}�/����)M�����c�=f���7,jd0X44�V;6|��?��7.q�^�mQ)Q�4�|�Y��OF���r�  IU1�+�|1��w�*��̃�Ͽ��������� |�OƱ�y���Q��G����/�ϗk�p�Y
�y�b'_���iT��Q?�o�c�����t�;�l��9�=y�/��{��ޥ�߽W� ��?���>��^wکTe[�U�³q��V.^;Lz�ѯ~R�����@io=[F����C��i�_�v���=&�����ǵ���o_T��.��p�',N7��ǵᆧ��2�&��o�.�7<��˩�ުh�[|5��2Z� w:TI���v5 �k�s&Voqh���AN<���J
_OW ��`�b��`��EY�R»��Qft��|/�E5iw�I=���1 *T�l���!2��"p�R}��ߤz���,��<Dԛ�5s�w�ٕ �b� |� ��#@$�����#�J�J�1�'ҟy R��ċԯ���d��.����b��#��<@�,!�H��Ӈ����.l���4kӬi� �6T  �|��T�@� 6�=�>�f< �����f�$�P�f���2������a��{&J% ��pD��\	3�"�`�ԧ�{9F���;�=�>��&'^31�K=$�?ٕ��·x ]���tq@F��  ��E�J)&w{����V1�Dc�M堑��&����@(��v�4C}3�͋.N���I��۰�ac#m#����a��i�E�����N�>�� \���N���������/��ݏI$O �aN?��4�s��x�9���1��m��� K�z/���O�ƓNXzKFnh�[4���\ǂ&�d>�lsTS���:���X�Gꓯ�Hx���h3��1�2h�'�H�����M���,*�2�/zWe�K��m\剗g�����_�|}Z=�Z=�I�<H��H=|�m�=_ ��� �6���}0s냙̴jk�VکB�d`�o3K�����Uu�ˈ~��~	*T�T>�K5��41h��u�xyz��\~4W.?��M �3�n 	����㕄k��ט3�N�{�'��Z�<�[���)_[y���Y�ܹr��r' ��yC�ukl52h��	��7�ق�g�:���Bjt 0\��ۓ/���)L�;V����wA�n�k{T�a��ڞ\csEu�i������v���ڤ=K(�^i�Vxd�[W㱗eZِ ` �&m���@�f�dO�����{�$�m�����/� ��>u��=�׿�����4�p[V�5㱋E��3dPg �h�Lo �;�A#=D�/zG~��4��[�PtK�d�/o;��T� 3a�����ݬ�k�kM1J/՞�t��Bz�ۧ#{=�v�	D�R���E3x�%�R$�� @
�y���1ҍ�CR�F����9k Ѧ C�� ���Zo�o�j�^�����tP_��Js&��Mw "�1]�0�zIavr}ۅ���B?��� 0 m ���k���* @U �[!O�x>N�lm�"�pї�]'����!�R�  �$�d�� ў�o��
���!u��_�z�W�B UJUHhj�} @�'�N��4��tO��1���t~��@��R���A��H��I&)A����C   ��!��d9 �h �W�%��u��z�Yt�:]�3XX����UfJ�=�<����Z�� �U�%U�Iμ�ΞӮO<���y��7��B��Th�g�&Zf�Y�Z�k@=H�|�^�0C DK�o�O?��Hz��IZ�E�E�20�C�������O�{s0��.s�u��ͨ�� ����P#&����m�+V�&C��$��=W|�f���*���2�Li?d�3hӧ�Cj�y���\g�Oo#=?�J�)�\I�*�N @5����5�[G����ݚ~帀d�]o����K~��cR�-��:�@(��jm r�Y_S�8�f"ͩ20�CD�u�����ر���a @���Б~y�U) Pu�*�A��O�] ��pw�R�����H2���Z�)*"�w=s��k�"is-���� & P4�F���'M'}Q��G�)u�v���UDM�zW��eP�Q�asa�ަO�yǘ DT�:>   �� �٪�P4�h�o�_�R�C׀V��[�4���A�{qI��M�<��m��?ye)�*4` `
 Ë���k}��c���c���+Dg�t`x��!�wwЧZ!y#������C �؛����,���u�����6\�襐�B߼�A�w[��uV���b���~�X�ޕ-���?�N��LK���d���um^\�С�C�ӏ��s�����Q��.WZ:�Z�����޻�E�����m��~�Uum��	F�[��ӟ�}���=m�~�6/�+�F �k�׵T���
ePM�T�'������Bc=`
�#�%��ɣ@�~��C>q�=>q�=R=~��D���G>�$��E��+��W0 ���ޣ�߁�#\��^L�j p��u_׸^7������ �\C�v|2�b���^WU$�Y ��}Vd���t���V19y�E4M��)$��O!|�/���?�n��q�'dN��+��v_����	 ~��br��]��4A!|��/�����q�+:�#y��br��F( G�{ �x�/��� �̽~�(��nF �ɋ۾t����"���k����o<%�g�Ώ�AD������������H �ÿK��#��K_|�i�w�{�@zE RZ9�y�K���������ݳ @��5�C��Q�7i�N|�~ǝ��_Ll5 �G�����W����Ο��
ȻДO����G�7�x����Yy��w��/��TMS߸E��� "����>J��7��i�t���oM�v ��k��ׄ�]�T9[)
��6w�[=��ْ�vI=��|�h����ַ}��y﫪�7�w �_���<jߺ�{�m/<�b���O�[�������YD�?��{�!Ƿ�vI�.��>i|��M�z��w�JR��������?�KϞ|7|r1����:��O�V�mqt�"P�_�w���>i|��]m�'������  �ο��g�d`����Ѭ���3�?ǋϽi��I%#e y��4 ��]1tX	���G�^���<'�� >v��(: иT/P��w}�/��㟿�Ɛ���j= ��űM ��W/�͡a˒��D<^����k��_�A��峓�"*�:�%+g��g���^���.�[Y�����u�so��Ϩ1}�B�B�ʕ (��R�u!|ۮ�2���x�ݯ��տ���??<i�Ϯؚ��>�����J�#k�k�"��&\��Aۦ'C�}�D>̛���j}��W�{���c�痫��U�~Z9�!ju6wom���K�OI��M�\���E��zէT��������x��uX�#�]�)qt�3:\�������Yj�|�ۑqtR�>�e�r��*/�?������xM���2�Y`]t�?��	"��>��o�W��ҳof������ @��v��u�O_�SV��f��u"�����?�x ��;��*�A@ʄJV��kˊ���vT��2��#��P�K�
��$#�~"�k[;��I������s����MZ@.�ľ�����,�V�M�"o�g_�
��ԕ��F�
 	8���֊�e��H��N/�4	���H����u�gC�:f7�v��W�3�o7=��Q���_1�� I�ckG/L����<�όۉ@���`_�����A�,Oϝ�_�M� ZD���Ww�.  �p�������ٍ��?�܍7�\�?��3Yo�{Y� .�J"D4���7=w㖝+wA�*��h���80$ �j���@��P2�-����>��2�ݸa��:��]�e�U�� (�"�.��Qm\��Q̤��IC�c���T���Kz�� ���i��%M9R��lRP���>W0�#Wo~��˃��f.���z���M$��+BD ��<]Jﹼ����?ׯ/�J��*���5�t�@!  Jl&r�#�X])ɛ�.:b3%ϋ!ԯ�H�\5/v�_���a3]>x'n������v#~O��7mVD'����gc�u��uϽpT�e]��Z�����oޘ��.��f��W���#�l]>x�s/���w^��*��t�&���`N��6M���NٚIy�$I�
4�N* E� $E��I�!h �*h�İT\,�\��=�ƫ�u�-����s���֔� "K%)N���^C�����zE o���c_�O�N��-T)2�*E m@�R� �4e�Vq��c�;�!&���9m7&�m7&��0{�e�e؅�Ү�9b� <3׎z������v�J.��סּ����Wm�V�u��cxi�+��b���W�|��Q:�v
 ����� U
Є����]წ�Cv.=h�PY(�r(��F����mM  ���  �R��˩���{?q���k?�呩��T�w�^:�ág~�3\��%�n�RO-6�b~1]�nʁ�9�A��t<����)ץō�Ҧb0:� �t�4eR���F�B§����X1j����u�(�|��e�(3T�R��Tl4��.ƞ�]}�鴰t�b:�EV"�ӫ�~��8��q���?�`it��O��������[�=9Y!3KپE>�YI��P���~�5�'��k�4�]��?����  �)+��l؟��=9�=yeIe�,�.�$':#��$��\��аg/���W�$"C�� =}���0�k��dM2�Ca�,'�Q���PyM
�3��M5��dhyv��l]�� @@ " Ks�����M�J��Sg�6�L^3�U���d�Cv~�Yܤ0�˝^� ��(����!յ���H����.X �fxF|�����\g���0�˃�g;�gk�	 �B�  Dӥwfk�
�Z��I��I��1����ћ�/f��́�Y�7�;Чߺo��l݊o��/}�͗��w?*6B5fR�7~-�Y�ro)t��ߺc���l�1�R�n6��f#�.��I]8���tfV�g!��a��7����ͣ?�Xt~N'�t�L���RE���t/�����*���"k����mNi@�3�J%ʳ�������S 4]�2i��%i�,�X% �n"�c/\�?.��� �/2 ��������+o��k��kN/ ��4��ը�&S5Z�֯<�V�8������3zI�������߼'��ꫀy-@y�S����wt(@�j����{���^�Sw��� LR"����e0PH@I�D��7��P�Nh�fo�M����^��� 0��(�o�y��"1L@(1��\�ǽ���u���w���II����{��{�6  �Ĕ�p�3�����%=�~��)��햗�Z�����~������ Oߩ$���JxJ�'z�f��� �vj�J��h呣E������Dt�/��ߺo��.<���7��+w�͟\�g���P��i9%�X^p���T�)e��{n���e�����S�U��\���]1�Lj�_��xv��?���r�Jzi3a�G?���h�!%��p5�lF���̣�̿=��T���Ou�og�p�1sP��2&��{v_������{��`v�7��{�r �����kI�y
�o�us�_Z?H��(x�ȏt�1��"�\�
#@�]��y�����C7  �K�7I���}�~����y߯^��n?�c9Z��a�΋o�������Z�Tb=̙]��_~���g.�p� �Dg��W���_`��+�l���ڰJ
�4�v�	R���/��"�x]����w_<.��_��� N{����|�������E����2h�a�Ns��������ޓ�rz���Q����w/�y��[�.�H:D$����8��3�>xbP��O=�\_+�#�� /������$qlӢ�0�r��3��5 ��� <�  \z���4����&�#���ƃ�tX���`���W�Yxz�N�):��0����o�?2�M}�� �?po���E���7�$��������<���ߴ.xH`�����]Һ�L<�Ɠ@(��h��;���y��v& �t�ͧ#OՑ`6 �t@W�v��7w�oi��L��P(f�����ח�|Z@ߩU 0�H j@@τ  ��Iq��E3C@���:B��s �������	��� p���@���޺��;��ힿ#�h���wɭ'W��P�Ko^��3}����P0 ��}�i$Fc�Y�`Qt�  `v7�1�����9J���+'{Z�u�ׂzF�9�w���=!|����	��tx )�@��FFC�V���;fјN�~a�&p��u�4@ �ѵ�P?�i	�^�����B�_�L`����|H�_X0� ��ڹ�h�I�j �%�l��~�k�VN���rw�?�6}��?�F�����`R<=���(	�[��K���u׿��O�Cy�]�2x�ë X;8�>����><�����y�z`y�����  �@Bg@G6� � �ջ��Xc ~ns�����A���5�0>�'� 6� J�և�Q����'K�ۣ��"�����$կ�\:�FY9�ʆ�rr�y�7�PΦ) P[)��w�E���I�H?�󮮳��-��r���~|�x @}3Ɏ8ol3 ��jΏ���o����n�� h�� �|���}֯���H�������~��� ���"�ҢO�D�~�������*}�㑜 �G�vpl��P�f��} `΢��z@�l  ;� Mt�vҧ8��A/�!E���9��@R!}�����LEV�z�����~R?���h���u;Ƃ�Q
р�7K �����N�j Aw���f) �jD��vp��*�s�#���՘I�k��2"�v�w<�{���� (����~���b}�I�� ��EC|�$��, �Ҧ�rI�=�i���f2H��K"���|�4O�qDf ���f\� ��ZKN�= Rt
����ty�����O��5��X����4u@��?uw_�#Fߚ���~�I2#-�5��{��G   �Zj,��h��f��  $�w�'y�1�x=!�Ҫ��M��_�����G�"���ah=y� ��{�dm�� r`*  )�j (�D����)�y�鉒�'t:��/��)��K��k���$�'�� ������ё�����R�h�rH�0 @�>;������,������E?�=34�(/���~	�c��Ѕ�>8��?4g$?��(��~K= �B�ۨ�a(E�& $KHm ��/Kg������XBR����G%�g����k���~||����MC���#}3��_�_��۽C����׏x�eP�1+��vܰ��j"A) �� R m�Sl����;/m��H �:/�Q��i"P�""�O��ˆ�=�������o̮~҇�cC4@ `0�,�XwG�͚h+��jhKs!i�D�S��<"���>���z��ԧ�b+��ug����i+PD����DS�$a���O>pY��������͏��QA{m�H�(���a���� �;��d@b��������]�/�G����� �f�?p�ʲ���ȕ��22H��CI"���M%�������n���;?��ߨ�d�,H���7iw�y�#��iH�����,�F �ZH������w~�����Qa�F�>��
�����O�'�50�_��08����
�O<�v��&]�\�f�@����'�!�O���)�imW�v}�� ��פ�06#�o����ݶ3�]�]�칞~|�/�7�eڭ'�-���=���v�4ݕ�~||��R���P�����Or�*\����+z�z	T"�2��M��E|�F\�v���� �sM�]��>8E�(��[�y�;���7N]�ޏbWk��tA�Y���+j�~��-�;K�B���Z��L�)�U <�?m/i᧵C�Zܬ��)���|�r �vqh�]ϔk7�7M�v"���Oz��p��?��ڑ�p��|'��W�=�Y��A�~X��Ao��4��kr�ho5B�JS*qݘ�]5��k��sM���;f�?8�p�AA�h����u�c1��a�=C��ݎY���;�2�h���5��g$=_ �Z�+�~�Ո�N=[}c$�i�r"�kQx�#������\��*�����EXH���q{�k�� �]��=�!�0�����O�âCHfF���N�!�b-�k�A�?��5��\�z ��/fٝ%����_��a-]\�(���9�fњ���eWi� �H �қ��9D�`��z�  Y ��쮁�$$�kҡ	`����._�;#�7x�V�r�'��Zj��,�"��U��Ca����>�K��%e�͚$�t��npza��&4�p -c�d�#e�eM`���!}��k��XY�&;l�F]���e�B�p���k /����Q��Lh��&��j�N�X�������c���u�DCo0�X��gpPN_2�:9}9��P	�$!<}8I��?Q���Q57J�b~�IF �th:=(q5|����@���+Qɍ3��29}U���`C�<��! ������3���ĂI�lF���a�:��$JMM��R K���`4�	�6����K�~���z����~d0H�L�V��&;b�/������E��S ��m�|ɩUÇ��ԏ6S���J���s��8���G%2�A>U $1�����f�'�8k�P�V����:<|��p�   i���f�>�L
0l���o}�p���I�0[  �/��W���z ���|��?�&  �ah�^�{�i���O�e`������G��e%��:����/�y�����  	�� P��h�[�|i���φ=7��V���7����/�+��j4�_{y���۞��e�  �� ���{��[��+�C��w��6�(!����n���.� i ��K� ܽ�c�U 0荿�κ]��&�BC�8<�Y-ǟ���~��Mo��k����v���[���U��������`���C�� �K��OO.�K
 �^ ����B�p�g�����ޮ���,�v��n� `w]�����r�Y���d`�����=����h�����kk�C=	�\/�C�m_{m���2�4��;\s�̈́���8xi䳭=;�����%yɋq��������� O�b��G٨c��Я��p�D|��~�3+ ǟA���>�N<z�?q���tz��^���o~o:��=�O��7=���tY]�-��8ϔR~�Do��z�Ac���sw鲺&���ˤd��xaQO�����[���`��a| �R �M�z�q�4�f����D�gg�x�2Q�M�?��f(�+>�G��oŉƉ�ً ��K=8�8�8���z9��"�7ǭ'{f�N|'>��G�;l�l�Ka���i��ҼO4@�?������?��$H���H�>lrsmd`���{'�IW��ٳ6��c�����rv�f}x�3�C@8���b����?{���/^vh�˧W���f}x��=��2x�r��!��cNg���{�9 ��v[28wu |��ض�7���Ԭ�|p����%�ߚ{`�7�o�~c��Y���u�I�;�  ��q��tq9vq9f���"p{�%��L{�b��&� �P�vp��>(�����TO���1�*�Vgd �M��XN��W�Κ^�!�v�[5k��o�}���!�zu֜�:3�����mjz1��wi��n.�6�x��r���Jxj{°~�o<аze�����M�������	�Z�� �κ_|���=���^~�_�D����x/ɻ8�돼�ֺ���3��M� <�`��zs�=��c�b�L����u1�Y���+�����O�D��?Z����xY܇�BZL���H�JΚ�o9񣌅��r� ]6�駳o9q���zH@�`[�@��5]��ی5�@�yk󔯿��͈$	��Ԍ~Lu�E���x��3o�7�ܪr�����6�Ң(�P�sͼ����
-���;7��������6;}[/g=$�W�'S��7�2��i��*�z �5�H������Q�?|�_]j'��w��U�D����H�x�w����M�����c�=ftΜx:�	=����Ʌ7Z�\߼h}�"���B��T������ɈwQ�  �*V�U�X�\�*�����w��=OG���`������߻�+��+C�/v�;�b��N�� �sҟ𞥷?]�G'_y�������C  w|����
��w�j�UU���o���0�HZ���0�7_굯�v����}�·>��o�<y�j�}Q���\�ő�V.��M�����ݻ;���ԋ��?��?�gmx�ҹ6���%6;u�1w߯��O�~LuS>+����UR��^W �%-%z��G}}5ٹ*)|=] �;��'��-������fe��S��`=�G��<��Մ�nr�78� *�Q��|O���&��n:����U�`��WW_���JW�=���廝mz�qdҙ���~G�&����C����}�V;=8�W��: *�@$��g\1X�#�J�J�%���L
>��;BD��.\1H=�Я��j��NE�!\�<��Ǥ���c�7e��1UI���b�0��mp�S��牛��(5� v* �0�)sK���<��rWz��Üf��f�z�Z����M���o�G���j`װM�=Q	 d��ސ P��� �a��(N/��\��R��|��z���a�M�S���^d��X���`�ffq@6b��  (G/BWZ��.`�f�8 #S��뭦�gk�_M2���U�ˠ�j�A��)�-Y��20ܔ,xQ�E��N����F�F:��m�L�Ҍ�fpu�����~�F����	�O=H���j�Kk,su���|��ү�s�p�F�T�"���EƋ̩��{��
��~8����s1I�T����H��X�D���d�����5i�  �W�*��9���,��d��*�]R��߰�e���s��[��U/���s%���wUf�$<A>��U�xyf|}n}����ק�í��-�ʴ�����+|�]`4�����.��fn���r'�R�S�x/����� ���w<�G�wV�����,w pf�&S���k�y����˳r��\��hZ~4 �ܺ��T���N5OA�����{�����fo�/?���ז3�����'�/�\⫻�W���i�s��?3o�w\eQ��j!�: f��������u!)�S����K���׸���䋱� � zH l��V=��e`8�a��;�\#[��-�z(�^��
��L|kn<v�R+g� � ���&��w8}V�u5{yQ��	�^ڤ��}�UE��po��X��� R 8s���5鞁h�j�o�x�b1�2���p�7ܛ����g���-El|����<Q�k �	��_l��؂��[�%}yۙ7�R�8����F?�L/՞�)8U�e*{�tN����X�`��^t�U�sҍ�CR��T#�ޥ9S���"4@ ���3�4���%�Y�6� "�Ɨ�"^�=�`�T#,��$3!����]iΓ�@Ҧ;�{��n�ŀ`t� �A ����/w��X �& ���' K�o��+O� T�P�8Wb�	��#L3袇�H���k�Ϟ�/���O�S���>��	�@ ���@�T�B|����o��W)U��6oa���G�	c}6B�!���A�D22�Ԯ�An���`70zbq�� 8{�
�K� P� �W�T\�Z�p������ _�T�F������ �,���(K���w�2S�ߜC�rr��?{x��S (�X؏�Tk}��IP��ҢP(�  �N� �$d��L��x�fk�B=C4�2���f��^�h�@�<s�s/B?��Xe����� �l���3�H��I���[,��y  �(��j �5��:����W��ŔR���B��.�:�P D�>k�  ��0jD��z��G���>}s��0�M5&C�d��߽  B�; �� �$]_K��-�)�\I�*��j6 91�k�}��X�5�����dp�ŷ���	)?���	���zx��}���W���=��c_?��˕@(�N�MU2�k�}G~e{Ƞ   ABG�H����l ��\U\�z׃��Kq�� �����_H�W�z��pz��Ҿ�M��۵����U�� 0�b�X��K�ki�wU�x��Q4�&z� WN�������EIȆԢ� �ޛj�/ְ�S�o   ;� ���������U��S�"^߇���N�FhHx�hu�:���a��j��f�4h�. �t6 ËU�~
 Ë�!�R���̋�Cs��nDd0��/����z ��L ������bM4�� 8 ���N���TWL\[��fl��5K!u�p}��'�R���7C
����3ꞟ��E�FJ1SW� �z�tN5q}�O{}U�T����'^>���S]�����?�m��>�4f�:y����})�3.PM�����������-��G�65>��*� �Bo����9��������Ӭ����FA`#����ue�Wz��7/h�L�%s�m1z�f�� ��V�+so@�����Z^���慯��* �`��EO��e���?�r��T �7ɇ��(�
����H*)��e�,�p?�jP�p�>�L��e�Pc�"*{���<�ć��H�=;���*c��ɵUe*e
���ҕv�m�6�����������+�H ��e�1 A�W�22\[	�D���ڙ��uK�} ��(P�D"^�X�KA>"$BI&�N��2YIR� Hqz �Lg2��Q`2��(I;�������Ɗk��g�߿B����2g����UE�����Dl�}� ��M��t˫�_1�˜b�K [C�2���2���UQ������,��m�P��Z��ZJ���h~���E�>������4��ל�+�{ @���?)i�8���ظ<�� A��  A4��|�F+l3�}�yX"���i�����4I hr0:��H{a;"��ׯ�eO �	ב�M�%&�V���v����n��p��,=����e��JKOYz*x8�O��U�T�
��	i�����l��<a{ ōVj��ϗN��"h�a*��?=_��������/���R@SO�!�Zp)�0	)�>-�Lr�����Q�_�#��
 Aʪ�O���)�y����<�.]�+i�
LհN޺�u�t�4��?  ᪓^��Ci��q�0 ����.o@Gq������7ȶ���(�#���SF��:�� �M��|�tE��*0U�ҢU�
�2� �ؔ�Q�� ���0�?�޲��z�� ����������S!���& �n>>V�v��0�zW���C �c>����R L����[�6�W��	�.1�a�p�ȱf�/{=Ї����-Wf� d��g�d`W�o��+�  d�H#=D�
y���+3 �$s����t2®N��tr-�#�I��k/��ۿ��� �`� O �: Dt�����<�U��#�l$  �0��Kq�/UG�"����S'	C�3��3�z0�Q 0j��� p���	�e`4������~�	� �1k}=����^��2�N��4ڛF{�ho�.,�lH���/��Qi	���0�@ �Q�!�aS����K���U ۠� ���0Ӥ�V�r�X�\b4��g6P�1
���j���l �&		���2��0�*=�����[_  0 �N �a�  "l�[��]/��?p��z: :�YG��8�����@���d� D�y�0\��r�	 ��W�;�z��y����MS��A���~�?<.]A�e�Lr|g����^W�:�B�gP
 ��a���_>}� `�[�0���_���>8����k3��ݭ�j.[s٢�6�/���"�%R%�r�y��k� ������o �iE�z@pI�i 65����[  sEVz)6���S+'{f�3�o��E�H��^�je���Q���0��o� �R������!>|�EO(Kh)��<�P��ԇ��=�9Ƃ�Q
��, P�0��u;�֋��Y�z��F1��e;��� �7� � �y�E_��yT�K|ϵG��F5Mh`���( 4�X�i���fP4D3�O���ӌY�^�-�0�O�L�LS�Ԙ@1C���/ڒ��:<�i�
�M��Gd Mr��
 
 q �֒Sw����7~�L�Bi�O�}�M2 M�4�*OOr�ӟ�{��N_; @hF�鋖������4W�x}�f���.���:�ͣ�>�k���Ƃ��6 ho�z$���Ǐ^  �v����%�u��I��?e  ����$O�Mo�$D�K�S�:�N�v/>s�< k �ȁ)  J� ��_p۽���ˀ������C��|��-����g���5�$%OO"�O�n���۾
�#(��6�� �}0��˓ן�z6����T����� �34�( �VxX��� M}ah�� @��DS�끯��/:X�!�DP�Q�$��6A�v�Sf���P��MP��� ����$�B�l��@,!)� �EN��龞d	�b�_f��}�֗��8=)������E4�O $�FHu���<_۽�<JT�z��������p�2I�D�E�Vx @ l�P�1ó�snX�j"P�� @+,���JcV����a9#�D��'�Ln�������(fH��8I0����Z�����` Y����{�&�� �%iZ  Fz8 Y����7�D_mq�?�n�-���XwG{� Y�V���	�4[sK�'��xw�ޮ&�����aXL2�| ����X��{�D@[Y󰨭�M0N��l�G��ȕ]�/�G���
��h�b���R�0N���'���e=|�ȕ�j��Ǣ��z H���3��/�>z�#Wv5|a��15����?��.i@Iu��l��WNk��Y��T8�k���s  ��v7Z�$��O��KE���y|���G�����Q�M�EAN9Y9M1�ݔ7��ٕ��x�0Y��`iү����ǙZ?������\���w
��di�e�ԋ���3���;?��ߨ�d�,H���%��`�v�ĵw�ژ���iA��C��-���!\{�g?����&딅���<����^��08�L���Åۿ<��s���t�FW6{n�� N���H�N�����_>���޲3�tW�Mwes��:�������e��dU���x⹶3���7���27��6�� �tL�q���畸uYn�����+�273e&W���q�z7�*��x���S������_>�瞱36fI6�&�2ί���%P����-߼�_\���.m�G�������E���+z�~/�[�9�/��o���F�k�>�d��CPG��L�|w|�����.k�޻�^! P��%9m/�J�^�[w$��Dq��N���F齹��Uxz��^���;;��q���K۷��emCoR0~4��� �š����{��{�ɺ�Ѳ  V�����Q�=^���<�қ{�ɺ��>#:�=��ˣ/�=p�d݉Ѳa��p8�K�P�k�kG��M�� ��O��eJ�]9yX�T=���>�9����{z���4�j�&�u���}���{>��i� ������'�����_wZ�}���{>���Z���m_�e��5\w:���{>6��?t�a���ӏ����J\g:C���3���5��C�� ��J�����o�?Y�c�1�u�8��/���>�R���Z"j@1����7�q{c�Q���maְ�1�퍩�b�03lo������O��������4�F���ƆU�`�X,̝a{c3�L $�)Eˮ2�GP�,���p�M���υ�)������N?�����*`q�-.�L/(fٝ�����l2����A���lq���S=���Y (�.� ���@  C��X0�za�F��=I�5��K('�3Ѐ�K�פC���<��,I��O�æl�5`:�C�� � ���?l�N�6��cZ �ԆZo5��<�t��k�J`�d�#e�eM`���h j}}'�7F�-��:I0��c
��<}ɨ^�F!Q�61Tv�u��^��K��za���\�d7Tc�A9��A?��Tr���ĂI�DU��<(\�xu�����%]1����$# �j:4������<�T%�3X���QU�@\�ʠ�7yXf𓴟ǧ..�m�\
� 124�	�e�dR%�0Xb�����55���^���\��L3X9�����$y�ՓOU  I�'F�<9�����}F�U̩ Ȉ�M��S��Ԫ�;�}V��T�z-M�u��{k��; �h�04_�
`�[�i~��s�  $m�0��ׇ��T��4?�=�ߏ��?�b}��������ý��7^�~����f����`���W���C?����?x�2R �Gp @awʀ�.�}���sE �_o�M!�zs��W���"��8������z����x��+g�y�F����x�]�z�~˯�����ο{�t�/ 7�x����m;��=H��K� \f Ї ����Fd`3��y�ί[20�������=��������W��vQ ��� ^
fu���)K<=���.)��K��^8[�$�ū]ޓ��3ӓ���i��=���K �m��9�z���%y���\[[眙>�K�c����=����l�"p��FO2(:�i�38~��Я��p����Rx��}��������K49�����>����C+{��{����d`�'�=� ����g �A��5�X��ax�LJ��?�?��e3})%s�.�}���/���e`�R�<��L��}ҽ�Smd ;� ` �	`� M})���d�}k�����[-=� �e�}�������r�� g� P&�w�� �^ �fK3Џ �h�#���*N|'>/� �$���� ��0�h�h P�p(l��#�E ��u�`^��@�#��r�(?�W�Jf>��q�"�}�W2� ArY�=�:k}2�p��<L/� �I�y���É9}��ی/^�31'���?��QG`�����L~FS��<B�f����i���������k�.^;f�����{3]챋=f����3���`=� X=���j(I�y@n�p�@ ݔZ��k'L����'���ל33�7扫@�[5k ���t�����&��q��C8s~����ml��@7��N�T����0���]�����Ks��yq��߽�<�S9aQk��zsѓV�X��	6�fШ�~w���`VC�L�<��w� ��3��M� <� X�3]��x����վ�:Sx��, C�7Ov��L7n��t�Y��쌁 �7���+��������z�=��O|����]�����i��?�X�{(�oV)�?�����{ �JΚ�}ˉm����0\�k�*�3h�3����A�[q����~d�����T�3�\�?jQ����y�-��F�[U��"��+�����_�s�E�a❛�[lo��>~v�]m�}u[V+$A[f�7^=���7�av����;���l�1o�e���x�/T
� �DC�8�u[�vl��1�:~x�b�ko\�νxۢR����EC�8���{l��LV�������G�3\�w�ִg`�P�D[���o�j���r��{?��wQ�  �*�uŔ/&��NT `�S��˿�wTϻ���P닝u�N���Ө&v+�|�Y��OF30Z�_y����������V ��'��w�d\��>�`v��j#0�zvCݟe������SՀ��l����\x6�|�j��k'l6��,c�׆W�)x�j�}Q���\�ő�V.��	��,���l�z�i�d ���e��7����w�> io=[F����C��	e`���I�L�2 	��h)����P%��?��  o &;l�/�c�b����t5 ���AT��Z_���������M�����ܜ��wդ}�M'������ �Patq���dgWT}�M�7�<��ڗ �,:�1��g  D�^d 	��  �#X@�� "�}��Q�P*TR-Y?8�~�}Uvv� ���q�`�G��y"�
)2��g^l'^K�Ї�.˦�rW�Yӌ �m� @��0����<R�"��M��.�^��7�--�>t�f�5��vm�5� ����o����T�3Q*�$�#r �J�	�)����J� @F�"���� .��kl'�4k�z�����sE�t3]����)k @9z�R��
��o^tqZ@6m�L�� �e`Ҧ���@�n�]�F땱�ac#m#����a��iD�����N�>z��Ɠ�����ц�4!2^dpu�G����[g ���㍍�Q��ڰўA�$�W�6}x׵�s �sbu�؎��j�`����C,l x�\����&�� �;��u,h$<}>��st���5�X����XX��ϱ�8��VM$_!�I���M2��]��.)#�6p!]|0s+|�;���IX��,�%vU��2BQr��y��`��
_���2�L�t��]��.	O�϶q�/v����V�
,?�R_l�k�T�H�Ҳt��wUf��d�m,\���s+|�]��|�Ԓ��T��c�B�O��T3<�Js���_Y�n��Ε0����7�;�J���~o�y��z�r5 �2|u���,?�������g������& u�3��^s3�zm���fZ~4Wz�3�n���*�����OH�J��{������s�Y|�r���n���gn}ӽ�OHc(A�T��[c �?H��ZP����xr�l���Oa
�k�n͡�-$�����0��woyr}]Z��e���v�EN?\��<�bdcZ�>y��Ӯ��z�-�~(���D�L�g �-� ���\[J�Wj��cp[�o�x�b1�2�̃_ � 8���Ò������ķ�=�]��K�� �����$�D�K{��g�[W㱗s��!��K gn�p�݇�zܨ��=������3��{�5ig����w����Q��[��6�9�IJ���o����$^�ڃC�$AVZ���!����?�,��������9=O ʖb-��`&ݞ��k����g`���){����<����^hu�d��-X(z�td������7�R���^�퉯��C�M5'ׯ��5?���9ݚ�c����͜��Q���!՞�`�dO I�-Œ��SE ��>$eB�ƂOw�9O�I���5"�B��IP�%$�X�Owus��
$Lw1�����8��>�Hc1|���9o�Ѧ��h0Dڍ.��?%�G�����M��2Ȃ$�E|��4�yLW��C��$�NG$	����@ �6 [Ξ�/���O PM �[�$�/%Z	 _���R���h�I� >n\�����U.��$� 3�t�铭�[3��{�󨊗d��1���ۯ�
M���L�����.*��dKhj�}��Ku�g�~�3 )J_��^�!���A�D���e��J�J6�Π~"�O7���?�A�d�'�	t�j���O� gϡP�$˩ k,�䫎K��\eY$�j���8���?{�
�K,�����,S�>������|��C�������Kj}f�f���Ѓ}���} ���C�w������}fJ�=�\��d�T�w]P߼O �&H`:C�Iϐ4 �@�^YJC���zIH̐ $�苡�����"=C4 & ��5��>��!�����OZD3@�$�P��S]99�>x����7�� [���������F2�^���������S�����5�n��I6| ̣.s���n�O�"��D��d���nK=D����2W|q3}�`!}�5�ے�O�g�:���a7�pk���.W�;a< �� �$��vu�ő_�J��Z�&�o_�?~ "D���Z��t}��������?�f÷e0�{�C�� E�X�� �Ĭ����:�+Ǉҭ���]|˯l� ҷ���΁�ǚ�& r��k�}���W���jmI2r�i&�~���' @G�H���(�{( �:�N�SZ���g~<   �ЯË�ܛL;�w=8�F2�^ J�e��;�?��� ��z��0��h�Ӭ��N5�w��w�� P*$(0�b�4�c( ���$	)�k�:��  �� �2�ˠh���F'}��9D�= �>ve�K�(�v�ך H��ړ�6��оYO�:�'�����s��V��Ҡ!~m�9��kN���z�T3��B�I8u|��[�T�L�P4��=�����{N���4���%��(.I�6U˦`�	�t2�4^�i�f ���{&N?���io��`�y�M4�]���d�v��T�0��hN�B��j��i� �  �w��R��3��?V�-FOػ(N���c��`o���RH]!���z� �k\�{3��(�+����
ߋ�j�gb>�>��j:���:��'�oH1�NzM��������tN��TuNU\��}b|�@W{*��?�m����Н@�	_��m����@ �?��c� R�:��e'���+h�H="���Q'��a}��mD������,�~퀶�tG}�����]�{����X�y���I�k�:�dL�d̽~�(��nF���L� ���m-�\I���оv�3�t��n8�� ɸ/Jr�LQS��h�_PyFt}�嫻��
�0���,(A/��%	��o�Iv�ijP�0�Ԙ�H*)K�k�w��_xz���,��d�(Fk=@ ��>E��>O���w � TP]��*c��	��z�.��C�n���� "��jG=k�v�8֓$�ב�I�$  $_z)әL3, ����gd2$x��@��v&k�R��j�꽰$�.@N F�����d�C���7S��~��+>�GG\Ig�o�ƪ�+	6Xty��|����J��7T�*�QR������~��+���7T˪�ZV:�AL ��@}����������+>��	ͣZ��ZJ����?$:����E�49����y7�|F�+��=�j��,�K�R�h���a�<�	@�̆IB��a|���nC�7k)3���^L ����W�>�E�dH�F��P�+�}����6���J1-������nwoߐVN�"G����ڗ*�[�� ��TJ�[�������38Y��k�;��k�<�Iv,w�����kͲ�*�اuW:�ط�p�#����5::}wC�te %� 0`�$$H�	��6O�=��]K�A�=!<�p՟��,Z\i�y�Hw�߅ �����A]��}���O5� �$z��r�Ǭ��5  ��^(��I���ɏ	�	�/�j��T_���k-f�O`v�ٺD��:=�c>��Ĥ����u���� ��[�{���  �o&�f�I������+��J:Gz��d���u�^j��g�d��)�8}�ȕ�dΑi2pn����d���o�r�<$	��+&�tS��y�<�U��#0! @t@��E �)��T	�+��JCO�Oc7� �����yt�w��<��<�.0�TK̫@ ��vA+Z*  ���0���ee�i4�ј�Y8=������뙤�
t��J�>�t�;J0U� ���K�MO�*�v.e4b�V5 l�`\ �/*����K�F�����l]�W`$���ν�z&�wVN�z�׏�0�*�yD��~ >�_:Lu.CP���_���  ` � ��fx�`������'���#�u����@��w�_�GG�t�`�d�<�H �1�$�-�z ʉ& ��R\���K�0J_Φ)�޵�wl�;�;�S��wi���yt�7&ҧ>o�_��\�u�h�� _�.�����]?׭�n�F��'�:�ޫ�������/�G����ЃB��>�X[��� gn� �ӊ$��P6 �� �J����,H!UH�z)RD3LC}h������՗%�< D��7�6��W�u����j�B �6�AV#�]�u;�� ���&mٜ�9%�^� �m��ݟN�A6�&�8��yT�dW���k����*}���>�i
@�d E ��E��`ӬL�2�0�0͘@� M�h�u�k@g}��I��{��c�ԧ��I��i��hN5�H�I�~�  �INSWD!  xa=uw_g}�L�z��i�U Q( �����H���$џ�� �۹ ��'����l�a�S-�':"�M���Ƃ��6 ho�z!��)D�^ڵM=t��0�����I�n�5^I�NS�:��j[=y�ׂ� ��.�� �����7�l�u���S I�j�T��QM�I�M�_1�:JG{�D~���@�>i�Q��%��Ku����TO5���������rH�P �Z�M`ںM���@aH�o;m��;mi���}�ѮO�@tL2�u��c���j!,�
�|	� n��9z`�t� JQ�� ��"���� Ҟ|�����0��P6��t�p5>���=�Փ,!U$��4$p۽xv��U?>��Ȼd��#�>>�z�%�N�TSf )h�2pcV��7,�4MJQD h�� �p�tW�6���R��Hԟ��uO=���)��]C�����GZ�^���Yyi�����6}��As���Qz7բ-4�Խ=6
 `0�,�X��Yme��Ж��)ZS�����$�5p ��z��^�.mm����>i��#"7������4�V��T��)P�S ���[���??re�����*!���:�\�� �`����,����]�ޕ�R	@EU��-�-\���tv�H���5�(����w�,���������#2��<j}���_�����*�z��*䔓����Mys�]Y�����,�F �| :����^������F�x�`v��d��U������m��M���?~���d��0XN5�{����^��08�L���Åۿ<��s���t�FW6{n�� ����hї�֓U��/caR6�;��+���9�9���I�u�:��)�� �(e�kק�
Dd���*��x�.G��$o��1O<����1ݑoҕ͞��ӿ��k*T����+j�z	T"��u�7�s��}�ƩK��Q�j-������#Q���e�囸�X�E�D��Z�ww��{@걪�ѻ��4dᖊ�VzH�X�3psM�c�-�����ϸ�};�z��L��|�r �vq������}���i��c�l%�
 Ъ?���>/מg/�4Yw"���rq���#�X ��tc�Or�L�&�A������y��?�7M��ef�59i���+M��Nw�����|���% :�����5�J\w:���{>6힏��hǬ��.K�e���C6c��#�=H����������Jx�ם>�ا�0�����4x��[�zr"�kQx�bLs5lo,����?R?t!��`af���q{��69�1z��@�� D�>�<Z�)�/�ba���q{c�1��9��z���eW��?��5��.�wX����JfF�f�,��T)#X�C���Z�Y�����#��@P�]�  D���� Ұ�a=�+��k����Uc}U�� �x}�#2i�0�Z��S���&;l�F]��1�@��
 ���� R�^�0�C���ڏb��<�٢��j(̃r��Q��	�B��LĂ��	�5�����lC%`�����ڮ�F�~����0IP�Jn]1�X0I�:4�<� ���n>y��k�ITuhʃ�վ��&Q�L�ͱF�G����gg0�zr��ԧ�AS���R ��i�6��5DS�b�����(�z�b���>f�` ��U̧* �$�#�'�V�w~���	DC?25���٦Z"�c5��!���u���cm�5�����3�  D�!�� "�QC >y抷|��|}hR(�`�APoذ�O��ΐ��Z_���no���j�*�S |�{�?�����]F
 ��  (Dԫ�r�/��?|y��[�2.ɟ�q���۞ڦ7�V�<8��۞އ�o�6��k��ӯ�+�����k/��2��jU�|f�f���.� i ��K�  8<qx<Xu�Z���}V��y���Z�F���w֛�W.�i��UO}��@��kgkz2՝���,����N�� R�� <�Y�p��>�!�ݪ7+t��9�IB�+����� ��3Z2��C�~g���:�POB1�K��WN>��ܯl��h	f`��m�A���o3��ڟ$�g���&�Uxn�h��p�׏G����+���!���>�ൠ�b�}3x�O��O�ݥ��lY��ax��0�?|�������z�֫ �g�'_={�  @���Դ����݉���+g@)��uӇ��e�Л��x��Xb2��TK�M�4�����;�� �<E)�w��V������2�>��m���ǡ<����R�p(L�~W=�p/��       [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://ctlcb3fcr8pcy"
path="res://.godot/imported/bow.png-6ceff24b0b7a2208273680cdd27cbe0f.ctex"
metadata={
"vram_texture": false
}
 GST2   �   �     ����               � �       �C  RIFF�C  WEBPVP8L�C  /��cm�Hػ�ADL�m�������ߴ���m�$I�$� �;戜�#�� &�,j�ee����0�kO�$˶-I1��?j�^KU�O�ʹ�Y�H�ΕE�%I�$I�-d��.��S����U� �³m[�$I�t �Lm���w_���À ��$�aki����$G���ˑ��$���	G������>�{VeE'	8�@!�$I�dfuy��X�Ò�p�m$I�D�z0:��+Gf�%�R�$ɑ$Y��o��AR��v"��$I��(�@\l�]�?~71���$)�1mL�I��g ��$I�$$Y�L�qU�]�����t�n3_%���$�$Q��j$�ɤ~G[��:��Ԙ.��Fb@}��5�N��`oɃvG��y�.�	�<Fs洢ۥ[���:\loɃnG{ޯw\|{������b��-y��h�!я��;�ޑ?��{$��;sZ���y��h�������4$��9�"��d�σ�Iԟ8@@dx/��L��SWcԝ9@5+]��vqG
֜�EрL��Q�c���M�H�  H� AbI�%�����, p @ ���ښ>�F^J�8
�= g96��]$H,�E���*�,�����A��%�go芨�MX��( X�g��\%�ѵ��>V6&3�詮��K�G-Zo�Z4+�,G�[�1*g6^2�*>�N��p� �=<��Xd�֚d������O�0S>���Z���	nZ���[V�x[ �ˑ��)Q�r���k� x~Yˣ]C�ߒ��7 `LMB�~�qt=� ��%�<6!�5��o_ =/�w �&�_r6��'��������",�&:��x�� cyI����xk��	dQr�p��N��w���z�5�#�+��3�	�A�$sƲ
Q}�ҭ�k�C�o	�J����G�Q�o/I��x��uz���Ý|Xp����Et�Ǚ#��� �	�o��6W�Q&��SL�~� \�Lf��oI�P�]���c��`�H$I�!���;9�@$I����n�ޢa��p�� ������!�B���C�*��C�~G��K� dR;�BT3G��vJbld{�~S�D���0���p���M�2ǋ&m��@�pj��_�D��u l����E�t��>%�닥�؀�I�,;�X��T��i�[�d�����J+��%��<�:\�Q1 _憎�FO7	͢���!	����4I���n�9��_Gۮ���VP��<"�H��M���#�9�Ok��*T��uxI�/���*���� v�� ��D�^ˣ�=DW�f5��4�<������	��?��.�GTé�����#[�~��$^b��a�ڒ9.`���j�呩�t�غ|M tCk�\� ����F� �Yc9�l���9��l �h� �|�z��K7 ���dNd��ǌ&����C#?��&������:��;��}���AI:%�'���3�<ĶN^҇{*-�t̰g�7����Ћ���T�f��m���.��U����xL�-ࣟM���cf�������<z�v���U �  �~��Ӡ���-�>׮{Ƚ�"ԃ*J3� %49�xK��õ�G�ncf�����Q8���Ϟь��L���hC��1�5�̲�HB�l�~ƴ1]� z=ZFA�n�OH�$C�!I�^+@���+��*�.8F/@�d��M�F_���-���5�#zt��|���cyX}
__�v)�1���?�~���,þ�� �>�N��*��f��FM��`[n���C`��]��p�^c��3�E�FX}Т%��z�6��c����g=�ӳ�B�������E����҅g���f�O
.TL˸��^����}���Kߴ}���g�g��}�$!�k� M���/���6ѳ϶8��]D1��&i�&w�h���l��5�Q�b�h-�����������돯l��N�iڤM�z<����������$$!ɑ$�v��Ґ�$�(Mm�і��6�g�||���a��_��&�#	IH�JP'���G����~��f9��͔&��ϐETS[���T�Ͽ?{V9�����F������G�N/m���{�h��V��/��ø�<�.�Ӏ�5�8�/c���7��AHTvs�g� T)�v���+�[kHE�dt�$FM�*m��ɠ��T�+� �&����� ��IEbT�[��z�bY U�G����i�l���`�k�5!�<c$�T~����� 7�c@@l��$+ꗺ�x�q�)���~|��Rk
���=�f>��`F�6�W���� ���ԙ�LjJ���5$ p���� ,�6$HL���n����8�1�x���SBXUP5���k����X�/���K�h��UVy~����p�wHp�����_�8\ �<(������y�=y�*����������1~����Td�"�K�&�ޯ,u\@ӯ�IM)���> c��UL{`�&��_�4OT���<�<�Nu�'N.��h*���*����
���<c<c�d��S�]�Y (�r|{I�ypT F�=�d~���߿��7���؟���C��8��h@�O�Ա�&`��%l]�r� ��{ ���lV�����FT�?��QÖht�`��e/���p�ʼd9$�Ҁ0?���,�d�@FTӓ0zW��_���v>,��u�sP@@�]� ]X?��d��:��o� Z^�>.��*��������T�"�8�!@+�`׷��X�@8�ϣ�axt�X�M<u��lYiı6q�E�p��X�Q ۊ)�}����g�{�|���҆$ �#�zr�!��~/�T؀��H�� 0&N��>�� �|�����h��w0���˥���$ы˗a���|�r4�-�x�p�w ��x�I׻vUP%�ǈ�R�1r���a_� ����>S�J�>�4�M@o����� ^�)U��#�}G���XF&��_����7	�E�~�v�4?� 	I�K�OIc�-S��~G�GR��uP��F �L�v$�d�-,�D^ɴ�����9Ɠ��_��{�,:-7ӆ���zy�a���_d�@ztLI��1rҋN�^v�*xI���O8뒣�zKF
����K ���kޣ{�c9 �8}%���$m�y2d�~���[	�K��"�蓱 m�'0*h3�a���C�p��/�����I��Ꮗ�I۷�T�G�TB�`V�)[	���&�������k  �<6��J0�;x	��L.az�= a{R����P��сH�����k�H3����pzY��钄$t"IN{T�$I�Y��k�<bӋl+	L�7��hhC������G�$���tmmd�=?W8��,�$ɐdi#�Z�O4S+ �4o:�s�<)c��N�p���Q`��%��ES*��<z�/�W��5p�;d�^��p�������2gP�w��JZ5�1�[a����v�?�Y��B�C�1�z�+i�2�>l ��,�4=�)y:�����:9H�SPTzv�_���9�l3�C/!�[�!7����������[ ̇�`������*hCjJ!�� �?��!��%�x�|=G��\A)�$o7�=��\]�v�u�U��rС����.x�ڡk��V���|h�4~'���[	?�7���|P��y��}ݤ/%t���&��'3��͟������?�*����;X�>��6���?��'���~n>�1�yC�-�o����r,�U@��4~�?ɯ� �$CZ���o���p��]7Ǩ���0E� �t�����I����-�m�$lHr�!��P�0=kli�$��2�r��żX�_"���d5@�=��D�5 I�&��gy��E sמE��K��Z���U@ա�k���~ �/�;L�0S�`�]��Ϟь6��I�8���k�l����3f�^�[���/����f~�aEC;�L�Ѫhi�
�;1F+ �n�}p@�NИʐ����8}��>��f�&��&a�M���h�І
X 0@�������;qF+X�a_oy��&E�{��:\��!��S��V�%fK�\��=������eԌ�Ѣ)p��F4�C���c[�EU���џ��_����i4�=Z������0f�	�̺Fq��gMK�^��.�����׆�����"3�m�0��L�@+@���!v)M�ʎª,��;�VM���i��䛰GŪ�hh ��^M��c�b�`4�.�M x@^0@�0:����N��b$q�TMv�G��O�EŐ�-�R5�-�hhc��i�YǪ�Ҙ�}$z��L�)ʮ V] -���:�tѮ�Zϖ���VP�+qb����4���Z�/X����UU��	**��:Օ��iL�FM��'U���L*_�?�=
Su�����5-��_O�	 /�/��H5����Me��������S�Z
�u L@�4h (B=	�[7j����k��Zϖ�5�p@�1bdF
v��u��j�
���n sȽdf�� ����,Zԣ�iJ�%B�iѾ�9��5�}�����8GBU�E�������#�����|��̶�ɰA{�RG�kJy���5-8�T�"�>�;��4rU+>�w�8���p+��M�*���<��#ӴHp`�g#�` ���F��I4��屙&Mc�C(�G�s��&�2K�:�0�y���zV1������q��
�x��12MmYd[zv
��Cp5G5��ŪD4M�����{�y�YVK���+��.�Gp�����v{���D�Mxw�W ��b��4����dU���g��9 Lhh<�y$�<<X9�J��c$��
G�`�gLt���=.������5ԣ6`-Y`�_�ϦD� i}�a%�܉�Z�V�f+ep.���{Ll@��٬vO���q��vI|��Nr��w�-^���}��ҳ��"G���&��< mhO´����Ew�'�Slc+�G��}�b_X� AaM��5��q�Q@ �����3�Y�*�D�|���a����v� Z����8�(�A*�6��7���[��=�=�+���dTe��C��;�گ�f��v���Qh �@�j��F��f��׮�]���^��e���{Wp�a]<���������?_(��8�q}cr��g��;h��e�<ȵ����� ��6)�؅c-.E�F`i�A0��׏��� 9�9�3�9�1>���&�#����m����r�<�>[� �?������zǵ�v6�ɒ��V��׏��-`� ����@�h�<.̃a��ae���f�C 0����������N�����w,?Ba�*�w(��Z ���GN�k�*ፍ.�h��Opb�P�����1� #�q���/Z�m���"v����Yׯ�9r�'�@5dL9%/�:@�q�Yb5TLL�j(���hv� Dh9P�@�
	��#�����18���V� =:�c�1�m��p�n�l�u1�{�4�@y���abL����V���"��GB1s�/��,����,`#=���# F��Qt�1��SxFL���<Z �EU��o���y�� �iW���;��9�C�s� `W���<G�wI�5�y^��mX�0N�#l�V�W��Z�$O@a������ޑMHw%Bz;0� ���"���`}�\$g]4��9����l���H��Ԇ�<��Ա�K��)�6� ���X�����u����|����=����l?:���l��3�(ӹ�p�v�oq0��Q,]��6|`6��+�=�{&-�/"������� �FQG�� � � v֊�y4�;���'��m��������k�|4q� ��[D[��f��H�P�̲�gS���q�cH���)m�������0���I��h��ī�!��$\�-7�9���+�k��Ӗ	M�{F5��, Z�4U{X��3��`���1�Q�j�jZ.3�u;L�jA]��244 ���l��0: `d� Zgv5��E�\�m����ӟ=�����;_h@�=����v��3�D�-4�ܚ>ɠ=�E��Vi�C�%�i9b��D(����i�Ў�6�U%Oj��.|�=�h��������zF �D(���|K@r����;�,���,0��= ��nC厚������w�~׮k���5�`�2iY9��n�{���u�h��$%#U��� �]4�I�QN�~�U�^�'�VOO��X�x�&w�?)�������r	 �Z��Z!�ܑD�;�IO����C� D%k�[����c�j���ɝy�'/��-��Ī ��_Hiߩ3�XK%~G���k�g�Mi�����w�j (sF�>���ʌzϒ�Ѯ �(eo�P/�G+w��rFS,�T���
���e��#4lj�m�Л=@J�3bٴ��㧱��c�_ �cU3a�=_��g{t(��g��à׮V��ҍ�#�a�wt9(��Q5�Z�{���v��4�a�A<�]�����H�Ή3�J
�gC�|���;��x>���ţ��C�dճ�CT���bORw4l{pg4{6 0��4���a_ۄM; kX��������I���6�*M�3�BϾ��� 0�c�� �������EP^���*p3#�*�'�J�Y�4���c�:G���<H�'�>���a����
�1bd����2ɝĲԶ�3	���FV���t�#C{��������t�9Х�V�Զ�S�!JVu(�n�B��nm�U%�j/�wX�-US����X�d�y��Z�U�h�ZriOv��Q �{�(�^�����G���d �,kf+�6��S��Ԕ��]�Ӊz��G)��vfҰhI�������� �M<ٹ���ښ�V�=��V�u�#hmױ*	��;b�pEl
�)��&�n\��8��-���V�M0���g����=��=�]�^{ �ڭ���.a�q]��# ?��|��q؊?��$����å��mf����W�.2���G�\6�Ӎ�j��#��V�e^� �<~�.@;"�-F��?�{;[#���}�"��Q�+CDG�%u�F#����)/�I �Ąқ4{�1
��V�w�����D�}�I�e�¨B��Shz��v��(<�* �	�Q@ ׮�]��ƽǾ�����D����I�q
�[f�g�z���iI;� ��U�.B�<�Bz%�K�*3%+�w��9Gi'ޫ1�sH�#�Ȑ%���CF���;*[ᒧ���D��Q�zw m�{��R⯞���a�e�-�����c|�I��~�Yᘏc��`9�ch5���Ǟwi��� r�ʼxהV�=?��`,N���.]*'�33UXR�&jYTp}4�1b��ID�p3��6����ߵQI�j�]��hV1*Z���hO�ԋ��Z�x,!P
�5S��(M\�&$�Z��mWGO���<r�}�I�3� �sTh���/�� 砼�q�X9��n��8\q���y�HHk�(O�$ H�H-F6��Gt�l� ��a���2��H����1(v���@�(ً]^z���C# �c��0�	*��Z0 
����a����:�Rh	%�}%lE_I$y�p󱪚�qH��LQ���b��a�P�α6,n�_h��l�G�O簫=
���a�M�N��]��z�
����^@
� `
X`	@��PD�}ig�(��#9��
����"	�"4���6�ab��n��5�BP�\�/�w�1��������6s�$?{wEqG��G��G�{X�A�}���(IC�d��ïړ  ��Ek�e$_X���1i �$�Q̟=�|��(����q��\��?�F�z������mhUX,C��0Zb��Н���J�[F+!li��;�]�4���\R��|t��Z!ۻ�X�5�c�m��m֍���`��>��<ɹ�8ŴX	��Q���c�2jh��l��z�w�U�����|;����@"��-z�j�u=��(TU�T���65p��g�Gk `��첇-�"���D�5�2�؉i{��z8��:�;l
�ۥ��K9�3��C�[���3m����J�v�C�v�"� x1�6}��`0��;9*:�Ӫ�m,e
{K[:�?��~O����d$Q���^���9(׮Ϟ�lbO_t�"�;�Լ��
�=�=���Q��,y����:f`T��Fj���͖�;j˳��O-� �յ�a��zюY �'	I&P����sͅ$�m�|{�raOh˓������DS�2��s����V~>Ӧ�T��Gka��)�{Bр:�{/�.y���i�M6��L��]�T9�/M���^�m�E.x�ͬI
#Qg�q�ܛL��x�%�+�ݬ��IҤ�kם3�IR���<iK�GRnf=�LZ%�2��9�ɦ�TH�+	mm�(�"�]����b���#M���"�f�$�$$!ɗIѥ�$�V�[��oKj�%���`�o��kL��M]��b$�h"�w���g����%�YD[d�I�$�-2�|�G�����A��ƷW�-2I�$$!�j� B�����k�3�%b)�@{� �I�7�_�@}������"��MbH$�% ��I�uVH1$�e�~��HR���7�x~y��������H �� ��Qm]׌b�x�~~Ye�U~���i��#�%js`����O���viۅ�p`8��,�w�o_h~�ãst����Q�g  2΁U,���a^Z���5��,cd���~�cl�����*��_�?�f�g�f�c�.k������^��eP���R�MdMp|�UtѵhFz��V�9�Y"��I�I~{��?�vcM���(=_r��zH�s{�跏=M��f`�>���FbT rn��G�d���=VFy��WkV56�	[4�M.�׷W��<�P2%���Xk�k_ݶ�j��e2|~��pi$`�F}�B�4idV2����Lɾި�n��h����ld�����dZy	s�%��j Ԯ}@}��"�K[ڮ;?���h ��5�@xr�%��K����C��f�}a�2tѵJX�b/����-UlAN/P�����"p�׷������x趏W	D�ҙ��%^�YP@��q����X/@7�f��M2������вUZ���2	A��e��q�p�;�+�uلG�С@6��i�6�TA�#����#�j$~���lLa�|�/H\��%��dl�X�h�ﰽZ6C�ĲY"��}aI��X����=�6m��f��~qz�) �̕1�RB��;���`iI�$Sv�Y�G{ϲ]%�i݉zE/l%���jN/�^6�i���g��U�������D2ꨮ+��[�������[��z��l�b5 ��$��k�\ǴkV@ď0�,G�����@�bX��I����I�Ԙ.�%Px�届ݐ�^�X�@ɀ5�$���" ��aa+ ��;�z�.�&Y)�[�;,�/�M5�p�d��"������&�����Da�3��C�y_��Y˱������ �kC6��Ђ���x�(�[��p�6.�Ux����&�Xp�R�G�!�ڀ�x~�h��JY�cy�"-�*}<Ȟ\��b�|�e�KV٤@b�MF2$�$Sl��g.�lV� �V��ɬB$��~DVo�����#�B:���?sqT����,�@"M$��$+I�M(��Z�n�M�$�",�[ W�H-���'	y`���$).���e,�@%Ir77��o$�R���	�A�ς�:@��rxĵ%Q�n:����b�"�d8����=����	(,�=�/���Sy�  X2,��Ȱ�XD$j]�ߒdK�r�BH�v�iX���v������j A ���(�r]����`�������3�C����w�^c��"���c�E ;-������Î��3k�ӗK�V'}�|{=���g=������c����VK���-m����}��U �g�ndP��5�jhc9h�c�$"]ؤ唌�O���a{�Ё׆�f��C�U� ����XE� q���'���Y�u	I�I�xj �B9J����C�Y �� �l���to��k�|z���4��K[���֡H���� PڲC�H\p�K[W������p�z�Y#I�<k:����v�'�S��!�#@u����|��{`\��by�$I�g��T0����Z|�z*&�h�tqT�%����5:��}u%{Ж$$YeE��T��?~������NW�~ צ��"pc&`� ����G]p*�ٲ�T�\1qѦ�6��������j<���1���-��=Z˩D��-q�f�_����AI ����A�޶>��_�l��kQ&$�H'�5���x^|��Ug_FpR�"��cf�;V�s^�x�!I��\Iʭ�m? �Ú��>@M� ��ٞ�H���'A��h{����f���̀����l�
�'A|�i���NK�U�g���ڤM�<���J�r`?/	�#�ŗE�y*���w8��6S����~�I���6#:}tʣ�d�ӟ�,�h>�~^�I�z��������6N_�~�ˋ�3�@*^�4:�FOW`������=	z&s�
����<eAnF��垯�I�w$��w$�IecN�FO���"����e. �ncB�:���S[�L�~]����lM�1��� uz�<�dVt��RS��y��x�v]�1�<�T`O���9��K�_$u��� �Ĭ�1�H��HjJY������UVy�/�v��S_#�8�k�_��G4,�������*���3K�����:\��|S$�T�*��5�_@O��s�kXD�<�1�.� tb���v�J����%(�h���V�a��Ys�)���˖������x�����$�%j�%V� haY��f��x�z�*�Nt��N�&ZS�-'�m����(R޷ ���dZX�~=.�� �<�d�i�#��z � ��������v���6S�[R���$��v���.�.;��G,�� -Z��T���4�΃��昮���\¸F����|fbH�C*�N���C�1�}D�W+���J�.���hyI�V@c�eW����d�SE��c�_?��@@cL�:]cʴH<��SA��4�*�rޘf�/��b��w ��U=@��Y]$` �(�S,G�ژ>��Ԓ��4pt-]^�/,�[� �XҐ� y�_ `L�^��g�@�7�U]�	��o^�+B�Q5=npE+�͟~�i�fJ3�ɪ��9޲��4�9� �������m��]���^�[�}��tV�f�5��!M6��t�y �4��9f$d���k�����M�����{�pe��I.����s�����*=��U��uۭ�;��^��&����o߁� ��t���*a=�HM)7x3���<6�q��;�M�cll�>��� �&�!���za��v@ao�2��i���_ /�a�=������p�u~�0/��ӡ�����L3{PsCC76Y樫���� ��'$��x9�E3�?~M`�%��>���
:}�!���ə���.iHs�Q�o��� ��S^�� n�<����6m��ӎP?�=ȩ-Ҙ�?~�ͣ�yH�%�a�r�nL��-���v��@	 `���=]P�x�� �q���,���[�Q���J���,6:G��&G�"�U@��8�D�M�9e�s�NrxyҨ|�c�"e'�"|]%�n�<@�p��_!�|���p!��)C�ژY�r�����+r�4ڤM7 ��6e^.��,��cӶyG99�5r?S��l�J��i��S����'�j��Ezǧ��3b x
���<@_I��)̐� ub�i�,9:F�m"�kR @]����a�]�zI�^���$mmg�հ���	��X���i��	_:�	p!W�!����&�1&���$y��\&\y�P�ڄ>�I� ����ZRr�v&�K�X�m)�M�&��&��:a�l�^ign��]�� ;О^��3 �}���v��$=@M,��^�Җ�����V��&�v�I3����I:%����y9@�� ��@@���;��
e6�1�.u�-��x	I�a����0_����	%u;�A���S|�y
�9���}HZ%�")Ihc�1L;�AR�Z��Q��#߾�c�����܌g ��+�8f3K[��|�t�u��8��M�i��C�X��v�mҦnz3���1��i;��kX֥O��m�����?�Ҵ�P/o� ���� 3]C����W@@��؍W��$=�S�����3i�}У�9$-Ǧ]�~p�Z�W� *�jZ�  t@L�6V	 �P F�7�M�������m��m�|zo�J.�f�x�������,�-��6�?�09��������Ѐ�
��:6�	 �;�7H3�3P����p�w �E��0�vi�	n�N]�����#ޔ�L��梶S�%�a5�9V���g��c��:\����t$�e��yr�Θa��� N;���%��Ř6�ˌ�����'��D��lƝd���9�]��1��<LRCA%���R(,�:6ʘ>$i*�{�xR�R�(C�:-$0[�(dݾ)��	�T&Ȑ�N0$y$!�+I�H�׹F��hV���t�m� &@�{z�w �@��q��9����rt��G�l+����5�˙;�yC�p�:\6��  �7�P"q�]9Ө���ޒ:ml�<���pmiZ<]A�n)�G���lY�%����P�����V��g��oU�E���v 7%S���1u���$|�q�J��*���K{�PV��ͣkJ�Oy~�m�tI����A�k���&��˪"A���Աn�:�$���� ��Ę
�s��;2�Г�<e;��h��"�:�l]��R����p�݁$I2��B'6Y���dH�tj��%n\�Oq�b )H�U���1�!5�,$�)u�]�]����*6,�u�HH�x�ʄ�9����i��6Y���'u[b`	����J� \Z�S�UL��c�ay�,P#����֧+Hrx��;DK`A@�:}�E�>
o����(�ӴɍWi�@��� �z�2�:��M?U�����4���;����G�2o�3���H&�&�|�8}����pzհߓ�I0t�� ��e�9�˧��ɬ�� n����
tzO/;�L�7�{t����5��Դ���$4��;'�����Ir��y�MP�Z5��]'�i3$���2U��$�=I��Ar�MN/s^�M6����&��P��K�|�W�cr n�D�E�L�Y$)YH�x�%�<�.���%�^��*�~H�6M����;�ق�1�.�ra���b�%���euEg��ɺ.�+���̕�W�$�E]�/vc~�G��o�i0�O�c����{�i�m����TJ��{������m�ٛ9F��t=���2�$qU������]#���L~��j&mEmU=q$I��y'�M��vN.t���~��3U�	�o@�7V��������o �1qz��.�̍�@��y�o�� �g�ώ�I��
HRFֈA����p#b��~��1@���ic��@�ҔҌ:Q'�����{�*��_�7���H�x���4I��:&N�õ�!�%˃��y���+!>_T�TB#����q��t����1I)��`T���g����D�������l��U�� �<���$5MA��yL}�S���MVY�c}����J9��HZ����Q-�1<<�]�&��& �M��Q"")�ͣSp9@ 16^��6l���6�f��\��j&�db��c] $O��Nl��Q�H�@La���;�{1{��B���D��uD�~�(k�*l�'��d��vv�.�g	���>$��$�KR��X�����!��8 ;RUI\���Uʹ� �u��H�|H��u��$9�6q���*�k�o�;G�Y�
�^¹cg�*>�3����TcT�D�"��M ����&�~"u84mlR �i�vIBZ�XHBDr�w�� �e�"�?�Z�I��V�1���"5O���]��x	�GK!�f>�M�$�.��d����8n\���zxYfӘ��01���=��u���vQڤ]�"��.l{�5��$I�8��8��XTJ<<�?�V�s����#ך�$9�pf�d&�w1�js���۷�0���!�x�/'�b  HB�5��w�k�a��s��l�� �bոo�/!؃����e�}'aS�e�$y��X	�F�f�����/Qu�"�Y����Vq�����.6f��&�7Oj���(�<�aښiV���[F&3����Ō
�[��˒��1f=C�wL��S�vb�,��y �����;�I9���-�s/n`ӚZ6��0��Ũ�I2����~p��[Z�`��0GgъR��0�rpɋ6�	��(�%���e���.��n��w�b�$v"`W^�[5�t �@1��ܰ�k�[�} Z`#���u�ؾ�M�$Yܔ��%�v35�nV	O?�4�2�~k~t��҄��0����Y���fY���s߇�5�!�Ж�9A0��l7CG��HG`�3�}����M���6y�Hb̰cpH����ڤM�Lm�^�[��7��L����х?E�0Ӯ�]�'�)ɲ�N;p��kz�ܶ&{#���	Oް���Ř�c�����P��Q�.L���~��.��3fЙ���L\wYZ
�1w��� Z��t�cpnh3����o�.9ɵK� ��	�`��V�sL�����&��Pd3С�{)���P�F��rL��DҧDG���*)�ռ�w�����x$b�� ie��Ss�d�������M��Iu�f��R��)x&�[��2f������]���~��|�yv�e���� 斦m�1ջ�qE$�HB�lI�#�Q���ѵ��0�z�xj����[���ec��&��?����B?��O��͊�#�����[��M�^N_�~�O�'6I�$!	I~8����Ysͼ�-�7ү�O���$@mu� ��3o��7,l@It�NjO�&�^��߄����|��]���c���˒!���.{܌���UVY������k��;=v>��d��dyX24D�]�����������sc)� 諟.����E��'Cb�����HW4�v����x�*��^� qJ��1kjٯ�:�"� � A��&���f#�9����� ���o�l:< �,�ǲ<����w��6x>���U �4����%˃�X%>>���U,��"��㣛��<���H�����gໂ�w[�4��q<� ;�-��貚�um�����x����2�`��ԥ�W��������[a��5��W���6�x� s��&�ː
U<�M&i��-lȝfrO;I\7W/'
Us���<� ?E>>�ǇO1� �2Gcde�����&9�$ɸz��b
Us������p+��������|��)S4F��\]���$|��`��_�#I�^�/�kH�[�} ���4~�y�V������������{��ɻ������2޶`Z�~z�G�"ipvƫ��|�q��9�E�S�Ld~��� ���P��%�1e��y����9\��u	�N��QA;I���K��'���4��>2P�/��F���&m�1E�l �{,7�lx|�����N���$܀\ ;��wt�"K�%v�G �k>;I�$C�!IIRGAJ�i��xl�^�,lPٸ�lH���>�;��F��%�4�6�d�~�b�8�2_{�i���1M?�3����<u�Kh�&�S��_�__��"0��.2�$�*�ЋW��yK� �Nr٘f��� +�x]�U��ֲ�2���L�$)�*���U?%)#=·g�1]c����w�C�/c9���� jԄ�N=��@�2����^��q�)l��s�c/��qM?V���*�"S��~Z~�&�,�*	��l�woMDf�x�sp�ۈ|,��A�E�p
gI��L�^��x�	��B�� ��?~��o��d�__�8\��o�X��!I�I�`�zvP{~v�,$���@�ء�o�Q3n�|}�'�r�� 5����!�� �j<�l2H����&6�h�#}�d}��� HB��&u(b���$bdV��Um��ĸq�&�,~l��-^�[���$I���H/�U�"��$�z|�-\��)���Y�*�j@��A;I-)[|���$����S󝀭�̒(A
IlB����I~�"}��u�z��L�!2��o�&�K��Yn�%)UA^� vY���vdB�rH�%�  D5f��Ny5Z��M�Ï�e�$� ?W���t�%�����w� PI������I||����້�ZN�D���y�^�}ܿ�'?ucoM�<�1u-WV���%�i����;8���&t���`��竏���������_�S� �ִ�q���:,�,�%G;=v>��3x�M�����;��|���ʰp�M��I 2{ܨW�$�n軸�fv>��S�:���l||�>N��V!! ڱ�r ۸B�ڷ����� IAu��*>�!}�L���~�9N�X�Rr����H�$���|���G�¥�2~�/Ê��!a�1ß���Y�7V�HJ�Kdn�|�~�8\�[��.�r�RΞ�l�]��F I||�ץ�x$Lʹ�t9|$��h�H;�Y0fo�m�̳���-eIƕ��{jgan/}^��*� \�U-�І����n��>eY��֡��$�*����|�I�	_-6.;g~|�!��94Y�J�DX�ͷ�M������
HR��x��IF�zG%}���UZʆ��Ժ��$ ��Ѫ�x�7tc�9�� . pO5F��h4*���͙��wc�[3�/���ei��!>�ݘ�,=��F�����D���Iꄋ��N�]�s�o�;�t��|�ڙ�x[�_I�'�D�������1c�`���$�� �        [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bb1bk5xw35isv"
path="res://.godot/imported/spritesheet_50x50.png-10631733a47c34275bccc35764732a7a.ctex"
metadata={
"vram_texture": false
}
   GST2   �  �     ����               ��       �4  RIFF�4  WEBPVP8L�4  /�ү��$I�Cp�8�u1���¶m����[!h�6Ng�W@P��h� � �	AY`b� à d�� ��
0�l@lPk�@��*�������w!Ā#*��x"�H@���6�Ir�����ڹ�
�4�U#,Mxa�q�'�Y��x"��;����Q�4j�ah���^t�0�Hp�@w���֭)hs֕��N�`yy�i�������Pgi����Bw6��~�o��Im[�~u�����2��m�:�����ҳX���=`@������03@��7<�� ��$I��
="u����>��[���	G��F�����R
����������_����?��?��?���O������?������������1�/
<ߖZ���(�_Zۡ�qm��k����_�k|��߆���������������?��?��?��?������������O��������O��������O;?F�����]h�����[h�Q�.4��ΏQ�-��(��%��?��g_����"��W���?��?��?��?����������O��������?����������\���������'�/�_6���?[�ͷ��__6�
�EQ����������O��������?���������������������O#�������(w�����w_�k�!���������������������?���������������������?��������p��������������������?��?��?��?����������O����?��?��?��?������������������?��?��?������O�� ߟ��[8�}i��V�`?迵5؇��m�����3����Ǐ�3<���>~�EQ�?��?��?��?��?��������O��������?��?��?��?���?x��?^-J.:.�x���΃����!���"w�G|�sC��V�">�+<�|�s=|�W�9���3<��~+����s<��_���X�K!k���O����?��?������O������?������������~wԾ���������08�.tv��1w��c���g�k�������)>���o�)^��x�%�s����_�C|�O�s\����?������O������?������������������v�ƻ?���%��	��k}q��	��k}q��	��k}q�����v�	�ϿD|�Okϝ�|U�!^?�����G�g�����������?��?��?������������?��������O��������?�k��q��>]�|]�|]{�>��'�s|��>m�
����3|���ϿT���W�o�
����������?������������������?��������o7z=������$�3|z������-�~|�G|�Ow�	����9�>m|������O����?������O����?������O����?��?���w�����@��k���5��7�3|z��gx�h����E�g���絟6~������?����������?���������O������?��?������O����?�˃�����ᇿ
��G���o����_�+�!>�F�������O����?������O����?��?������O����?������O���|����?�[<�!����~���3|�?�G��(o�����'�K\����?������O����?������O����?����������������?�����=��}�G|��R�[��>���	�%�?Y�k����?��?����������������?��?��?��?�����������������K�7��'O��-�����c��_Vx���������������?��?��?������������O������?�����`��?��?��?��?��?���������O������?��?������������������������������?��?���������������?����������������q�?�#�������������������������������������������?��?��?��?2���������������������������������������������O��������?��?��?��?��?��?��?�����������������������$k�����?��?��?��?��?��?��?��������������������������~�^�9^�O��o^�%�}�OZ��+��O4�迀�_��������O����?������O����?��������O������?�Z��w��7�����#���sӽ���G?���t��xJ)�?��?��?����������?������������?�����������O���|������_������K<����_A�,迀��̧��?��?������O����?������O����?��������O��������?�,�!>�ʼ����?��X�K�/`)dM���?������������?��?������������?��������ￏ�kħO�_���h4ʻ�����7�؃��࿀=�������O����?��?��?��?�����������?�����������ϟ�������W�/��V�*���~��/`������/C�U����?��?��?��������������?��������������W�=|���*������)������������?��?��?������O����?���������������������?���wWĻ"���O�9��T�)�������ᣯ�Vg���k��뿕�?��C֖��O����?��?�����������������������?���������_#���R������������������O����?��?��?��?����������������K3|������������������������O����?��?��?��?��������������͘����ݯ�O��[9���S<�!�{��뿀��_���/`��������������������������?����������������������������!{�g��X�K�/`I����������������?���������������������������������������O��������?��?��?��?��?��?�����������������������������?��?��?��?��?��������������������O��������?��?��?��?�����������������O��������?��y����������������O��������?��?��?��?�������������O����3|���S<me���=�>�뿀��_���/`�������������������?����������?��?��?�����C��_����W��J������#>�s|��)����=|���!�����������?������������������?��������ϑ���S���U�|�>�s��*����y�������+|����__������뇬���?���������O����?��?��?���������������L��>��/_���W�;��S���s|�?��߿?o5���������)���s|�k���W�c\������?������������������?����������O����S��\��#��)�4�{�?�>��^�#�ǽڟ��6~�������g'��o��|���~�B���͖� ׯSȞ��C��R;������y�����Nm�B�W����?��������O��������?�����������\!t^�:/�_��b����xė�������"���
�����4�_�c�(�"��%���eY��֎������fSyl������������?����������O������?��)q�קR����*�]��K�~|��"��W����V֋��_����_��!迀����������������O����?��?������O������?���������?>��x���V�6�������K<���x�Ch��=+�Dh��=+�Dh��=+�D�!s������������?���������O����?��������O������]�����V�v�/�2o�k_n���;J�K� <B�(5A���rF��?����qj�������������������?��?��?��?���������O�������_�f�����������?��?��?��?��������������_���������Sc�?��?��_k��������������?��?����?���������O����������ɴ��P�i+��K���MQ��f(�_{B�/C<�K|���!~�ް����?��?��?������������O������?����������ϗ��ܗ]��a_�w�!���ٻj��w�F��]�AȝG|��p�_�k�!�?6~��#|���7x����������?��������O��������?���������8Oq�Wζx����O�_\���{|��+<�%�����xޫ(�b�����o���?��?��?��?���������O����?��?��?���������������q^���+\���w]I��9�+��2�u% "�l�5�W<���Ɨ���#�����������?������������������?����������O���k���?[�ͷ��_wx������������?��������O��������?�������������ͨ">�#����h+�_���X�K�/`)d����?��?��?������������?���������O����?��?�������ͷ���C|4���+˲|����������������O����?��?��������������?�������������v��v��vсp�sg��x�G[�m����[�~���=k���/`A�,迀e����?��?��?������������?���������O���[׃���]l���?�GTS����O�s����"ou�G|�/[�1�r+�>���?��x�68w�G�J��R���+C�X����?��?������O������?�������������u�\�Ǜ=�;�.�U���YG�e�*t<넺�[�΃g(�_���Qħ���/pn�?�˭��|�O�-��?¹3|Z��x������#B����O����?��?������O������?���������������������Ź	�k|�/�%�W��˗/�N�~�����#>���p��������O����?��?�����������������?��?��?��� \��i���5����>���W��9~�?�c��j�����=������������?���������O����?��?��?�������������u�\������������>v����}'�s�ϻ|��'��[����#�����������?��?��?��?���������O����?��?��?���׍��}z����B���űc3����O�?�y�������w�9>������x����?��?������������������������?��?��?������O�����[���k<��#�����p��������O����������?��?��?����������O����?��3�s����"�srrr���⇟�����u��;�|����������?��������������������������?���p�w��������v�2��=��\�}¿C^��m�O�
��_"��{�?�������o���������������?��?��?����������O����?��?������O���j����G�����%~���������������������?��?�������������������?�㿋�%��{x�Ƿ����������O����?��?��?��?������������������?��?���w��
�����{�������>�{��D��D��D��$dM�����?��?��?������������O�����������K����R������K�����_�K|������O�	���O����������?��?��?������������O����������?���`�?���_��_��������O����?��?��?��������������?������������?�㿛���7|�Wx��������o�	��mp��������O��������?������������������?�����fH3|������V�]"���~���<��?�'����֟���xȾ>.�]����8n���☵ˎ�����������������������?����������?��?��?���������%���x��o�G����e�g��_���EQ���k�[�g���?��?������O������?������������������?�����fP|��_�k|�_neކ����W��_���B��V迀�/`E��?��������������?��?��?��?��?��������?F����H��k���5�y���/�%����>��֟�|�W�����=<d��̉�؉�؉�؉��?��?��������������������������?�������hn����[���9�|��}q�G<d����?��?��?��?�����������������������?������������x�G|�/���n���������������������O����?��?������O������?���7C��~���x��~�x��/��7����������?��������O��������?������������������C<���f���x������/���}n�S<d�y���G_���!}��6><�������P������������������?����������O��������;�����s<�/�r�RE1��������+迀����������������������?��?��?��?������������O����?��������~����vT����vO����=��������O��������?������������������_�C���i+�F������k�?�'x�K_������뇬���?��������������������������?�������|6�SJ�ۂ��c\�����.�_����B����?��������O��������?��?��?��?��?��?��?��E�1^E��P�?��m���ӏ�_�~���#���l���?���������O����?��?��?����������G65���?���Q�G|���a��w�O�{��������������?��?��?������������O���������u�����S���U�|��/|�/��ϟU��{[����#��鿀�H��G![���O����?��?��������������?��?��?��?��?��?���w��_�C<��V�kNNNNz�����S�޽{��^�}�_���X����?��������������������O������?�������~�s�Ox��F|����9���׈��)���_���X���?��������������������O������?��?�����_����W:�o���7����
�s3|�?Ƈx�(�c��1����_���X�K���������������������������?��?��?�������l�<_S���|Q!i���拼Q�2çx�����op��G|������1����K�=q���
������*�?��?��?��?��?�����������������������s���v��v��vӁҫ}�ʼY�sK|�s|��5~�/�����pn���N�_�N�_�N�_�NB����?��?��?��?��������������������O����{���T�|�/_����_�c��a�/p�1��V�]�Ǎ�/�x�}�^����O�|e�� eާl����+�2�S�C�d�%H��e[�L���?����������������?������������o������͟6�_�c|����/�2�ӎ�usss�_�<�~!迀�������������������?��?��?���������������O����������#>�~���1��;;n��������������������������������������������nP���O���W���U꿼F|���Ǹ?X�\��������?��?��?��?��?��?��?��?��?����������������a�˭t��ڇ�}�_�e���]j���&(�v��Y(���إ�HA+�MQ�?��?��?��?�����������������������������^���Q���ѐ����������������������?��?��?��?��?��?���Ԙ�������W���?��?��?��������������������������������_��X�A���h����S4A�����_�<�^������?�������������������������O���������+��"���~W�/`W�/`W��P�k����;|�G<�5l|����������O������?����������������������&���/`O�"迲<m�����±w���������5��������������������?���������������������l����J����+�W�O�5�l�q����������O��������?��?��?��?����������������n�5�~<�u�7�{\��������?������������������O������������?�㿛������?��x����y����T������S����������������������������O����?��?�㑫�����5�|��G��������������������?��?��?��?��?��?��?��?��?�����w��c|�o��}��ָ~H�/_I��+�|'�������������������������������?������#�����+|�����5^?�=k������/_��|}�������?�����������������������?��?��?��c����/`��_��鿀=�����)>�����+�3�����=>�#������o���?������������������O������?��?��?������g�op���^�^�z�)�ƹ�+|�O���#��������������������?���������������������^�Wp�Wp�¿�#����������������?��?��?��������������?��?��?�����������7߻F�_���_���_����x�&���	>o�i��?��?��?��?���������O����?��?��������������?��/`����؟�Ͽ���s|���?��?��?��?���������O����?��?������������������o}�G<d]��+|z������������������?���������������������������������8��n��������[\������������������?��?�����������������͟���?�~�Y��O~�Y��O~�Y��O��§x����?�|z��'� �G������������������������O������?���������������������=���7x��+��s�/q�����������������������O����?��?��?����������.�)��7x��G��U�����������?�������������O���������������������������~�������_����?��?��?��?��?��?�������������������ߺ�뿀��{���J��S|���7���p����������O��������������������?��?��?������;|���#�������������?��?��?������������������������?��H�_�����w���wx��Q���������������O��������?��?��?��?���������������o��?ǧ��3��?��G����)~�o���Ǯ�_���_���_���������������?��?��?�����������������<{���'x��������k;D�+\����?��?�������������������?��?��?��?����������O�-"�?�5��78w����n�5^���j���%�p��V�n�����}`���������[����������O����?��?��?��������������������={�뿀]鿀]鿀]�B}���%�?ÿ�#������|�O���p�z7։�؉�؉�؉��?��?��?������������������?����������oow�s<�S<�����G��?��?��?��?��?��?���������������������?��?��?��?����5��#^᷸��?��?�������������������?��?��?��?����������O����#�s��x�Oq���������������������������������?��?��?���������EQc�¿ŧ��?���|��������������O����?��?�������������������?��?��?��?���w�M�i���!�^���s��+�|%���������?��?��?��?��������������O��������?��?��#V����/�	���p�w����z����F������?���������������������������������?��?�;"������x8�}+>���P���C����������������?��?��?������������������O�EQ���]��?��?��?��?������������O������?��?��?������������/�������
ϟ�?�'���Ϗ�_�~����c����?�������������������������������������+P��B���+�_ac���;���y�7o޼��p����������O��������?��?��?��?��?��?�����w���r�������W��������������\�����/_?�����������������?���������������������������������k|�s�w{��͛/��g��ג��W��J�/�I������������?��?��?��?����������O�����	�֞� ���S<��wxď^K�/_I��+�|'�������������������������������?������
��
. ��1�?������~�/�~�^���U�|�/߅��?��?��?�������������������������?�wt�\���_��G��I�������k|����o|����n�@��K�/ �Im��_@��!鿀��-���?��?��?������������������?����������������_-�w��_;��_����W�	�p�����������O������������?��?��?��?��f��V迀�/`��+�_�<�����%���������/_��|���O��������?��?��?��?��?��?��?��?��?���b+����͸��_��/~����	����uIm�俶�vx�_YS[<����������O����?��?��?������������#�b+����͸�����!��/�hI�,鿀%������������������������������������������O�����v��v��v��
���7x���R�����|K��������?��?��?����?��?��?��?��?��?����?��?��?�}���)�W���MP����P��MQ�?��?��?����������������������������gͨ�����������?��?��?��?��?��?��?��?��?��?��?��?��?�������               [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bumjhe4rqxehd"
path="res://.godot/imported/spritesheet_50x50_fixed (1).png-9b3f8e08b9c75b9b309b05ed405797a6.ctex"
metadata={
"vram_texture": false
}
         RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://dash.gd ��������      local://PackedScene_rup36          PackedScene          	         names "         dash    script    Node2D 
   dashtimer 
   wait_time    Timer    	   variants                 )   �z�G��?      node_count             nodes        ��������       ����                            ����                   conn_count              conns               node_paths              editable_instances              version             RSRC   RSRC                    PackedScene            ��������                                            P      AnimatedSprite2D    frame 
   animation    ..    AnimationPlayer    resource_local_to_scene    resource_name    atlas    region    margin    filter_clip    script    animations    custom_solver_bias    radius    length 
   loop_mode    step    tracks/0/type    tracks/0/imported    tracks/0/enabled    tracks/0/path    tracks/0/interp    tracks/0/loop_wrap    tracks/0/keys    tracks/1/type    tracks/1/imported    tracks/1/enabled    tracks/1/path    tracks/1/interp    tracks/1/loop_wrap    tracks/1/keys    _data 
   play_mode    auto_triangles    blend_point_0/node    blend_point_0/pos    blend_point_1/node    blend_point_1/pos    blend_point_2/node    blend_point_2/pos    blend_point_3/node    blend_point_3/pos    blend_point_4/node    blend_point_4/pos    blend_point_5/node    blend_point_5/pos    blend_point_6/node    blend_point_6/pos    blend_point_7/node    blend_point_7/pos 
   min_space 
   max_space    snap    x_label    y_label    blend_mode    sync    xfade_time    xfade_curve    reset 	   priority    switch_mode    advance_mode    advance_condition    advance_expression    state_machine_type    allow_transition_to_self    reset_ends    states/End/node    states/End/position    states/IDLE/node    states/IDLE/position    states/Start/node    states/Start/position    states/WALK/node    states/WALK/position    transitions    graph_offset 	   _bundled       Script    res://CharacterBody2D.gd ��������
   Texture2D #   res://assets/spritesheet_50x50.png ɭ��U��"S      local://AtlasTexture_f2ett          local://AtlasTexture_vsg3y Y         local://AtlasTexture_670r0 �         local://AtlasTexture_tn367 �         local://AtlasTexture_sywau (         local://AtlasTexture_iownk m         local://AtlasTexture_48shf �         local://AtlasTexture_vyrsu �         local://AtlasTexture_25sk5 <         local://AtlasTexture_vv4jr �         local://AtlasTexture_ayk4b �         local://AtlasTexture_tha51          local://AtlasTexture_g3jrf P         local://AtlasTexture_1fvfo �         local://AtlasTexture_vpekb �         local://AtlasTexture_g4mm2          local://AtlasTexture_t31pf d         local://AtlasTexture_7hipf �         local://AtlasTexture_p08bb �         local://AtlasTexture_8stb7 3         local://AtlasTexture_k3t3e x         local://AtlasTexture_alktn �         local://AtlasTexture_mkkip          local://AtlasTexture_klkeb G         local://AtlasTexture_1slxc �         local://AtlasTexture_iv6t1 �         local://AtlasTexture_ii3ig          local://AtlasTexture_np5ao [         local://AtlasTexture_jlg8l �         local://AtlasTexture_5bk30 �         local://AtlasTexture_35wlj *         local://AtlasTexture_4p0a4 o         local://AtlasTexture_aqw0d �         local://AtlasTexture_46fc6 �         local://AtlasTexture_im51s >         local://AtlasTexture_qwqe5 �         local://AtlasTexture_6offy �         local://AtlasTexture_jw307          local://AtlasTexture_2d6up R         local://AtlasTexture_u0w5p �         local://SpriteFrames_p5q5m �         local://CircleShape2D_ewifb �.         local://Animation_c2y1s �.         local://Animation_mykxi 1         local://Animation_oqki7 �2         local://Animation_b0lpk �4         local://Animation_dkox7 �6         local://Animation_gteyb �8         local://Animation_5frmo �:         local://Animation_nqli8 �<         local://Animation_kk1qe �>         local://Animation_5g153 �>         local://Animation_1p8yk �@         local://Animation_7tche �B         local://Animation_fyqub �D         local://Animation_awhlf �F         local://Animation_8l3a8 �H         local://Animation_0ap51 yJ         local://Animation_3wvwa �L         local://AnimationLibrary_rq85s aN      %   local://AnimationNodeAnimation_gjii5 DP      %   local://AnimationNodeAnimation_m8tev ~P      %   local://AnimationNodeAnimation_30hbx �P      %   local://AnimationNodeAnimation_hurdd �P      %   local://AnimationNodeAnimation_ev065 ,Q      %   local://AnimationNodeAnimation_qhmem gQ      %   local://AnimationNodeAnimation_he7oe �Q      %   local://AnimationNodeAnimation_kvyn4 �Q      (   local://AnimationNodeBlendSpace2D_uyp4r R      %   local://AnimationNodeAnimation_0yd3n NS      %   local://AnimationNodeAnimation_sh3nn �S      %   local://AnimationNodeAnimation_smaih �S      %   local://AnimationNodeAnimation_f7cr7 �S      %   local://AnimationNodeAnimation_i7pyy 0T      %   local://AnimationNodeAnimation_su7wg fT      %   local://AnimationNodeAnimation_8ogfy �T      %   local://AnimationNodeAnimation_jitcm �T      (   local://AnimationNodeBlendSpace2D_7v3ju U      2   local://AnimationNodeStateMachineTransition_0r27a >V      2   local://AnimationNodeStateMachineTransition_keyu5 ~V      2   local://AnimationNodeStateMachineTransition_652jh �V      (   local://AnimationNodeStateMachine_83wpj &W         local://PackedScene_ehtw8 /X         AtlasTexture                        �B  C  HB  HB         AtlasTexture                        C  C  HB  HB         AtlasTexture                        HB  C  HB  HB         AtlasTexture                            C  HB  HB         AtlasTexture                        HC  C  HB  HB         AtlasTexture                            HC  HB  HB         AtlasTexture                        HB  HC  HB  HB         AtlasTexture                        �B  HC  HB  HB         AtlasTexture                        C  HC  HB  HB         AtlasTexture                        HC  HC  HB  HB         AtlasTexture                                HB  HB         AtlasTexture                        HB      HB  HB         AtlasTexture                        �B      HB  HB         AtlasTexture                        C      HB  HB         AtlasTexture                            �C  HB  HB         AtlasTexture                        HB  �C  HB  HB         AtlasTexture                        �B  �C  HB  HB         AtlasTexture                        C  �C  HB  HB         AtlasTexture                        HC  �B  HB  HB         AtlasTexture                        HC      HB  HB         AtlasTexture                            �B  HB  HB         AtlasTexture                        HB  �B  HB  HB         AtlasTexture                        �B  �B  HB  HB         AtlasTexture                        C  �B  HB  HB         AtlasTexture                        HC  �C  HB  HB         AtlasTexture                            HB  HB  HB         AtlasTexture                        HB  HB  HB  HB         AtlasTexture                        �B  HB  HB  HB         AtlasTexture                        C  HB  HB  HB         AtlasTexture                            zC  HB  HB         AtlasTexture                        HB  zC  HB  HB         AtlasTexture                        �B  zC  HB  HB         AtlasTexture                        C  zC  HB  HB         AtlasTexture                        HC  zC  HB  HB         AtlasTexture                        HC  HB  HB  HB         AtlasTexture                        �B  �C  DB  HB         AtlasTexture                        C  �C  DB  HB         AtlasTexture                        XB  �C  DB  HB         AtlasTexture                        �@  �C  DB  HB         AtlasTexture                        HC  �C  HB  HB         SpriteFrames                         name ,      EAST       speed      �@      loop             frames                   texture              	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            name ,      E_idle       speed      �@      loop             frames                   texture             	   duration      �?            name ,      NE       speed      �@      loop             frames                   texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            name ,      NE_idle       speed      �@      loop             frames                   texture       	      	   duration      �?            name ,      NORTH       speed      �@      loop             frames                   texture       
      	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            name ,      NW       speed      �@      loop             frames                   texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            name ,      NW_idle       speed      �@      loop             frames                   texture             	   duration      �?            name ,      N_idle       speed      �@      loop             frames                   texture             	   duration      �?            name ,      SE       speed      �@      loop             frames                   texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            name ,      SE_idle       speed      �@      loop             frames                   texture             	   duration      �?            name ,      SOUTH       speed      �@      loop             frames                   texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            name ,      SW       speed      �@      loop             frames                   texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            texture              	   duration      �?            name ,      SW_idle       speed      �@      loop             frames                   texture       !      	   duration      �?            name ,      S_idle       speed      �@      loop             frames                   texture       "      	   duration      �?            name ,      WEST       speed      �@      loop             frames                   texture       #      	   duration      �?            texture       $      	   duration      �?            texture       %      	   duration      �?            texture       &      	   duration      �?            name ,      W_idle       speed      �@      loop             frames                   texture       '      	   duration      �?         CircleShape2D          
   Animation          ��L?                  value                                                                    times !          ��L>���>��?      transitions !        �?  �?  �?  �?      values                                      update                value                                                                    times !                transitions !        �?      values             EAST       update             
   Animation          ��L>                  value                                                                    times !                transitions !        �?      values                    update                value                                                                    times !                transitions !        �?      values             E_idle       update             
   Animation          ��L?                  value                                                                    times !          ��L>���>��?      transitions !        �?  �?  �?  �?      values                                      update                value                                                                    times !                transitions !        �?      values             NE       update             
   Animation          ��L>                  value                                                                    times !                transitions !        �?      values                    update                value                                                                    times !                transitions !        �?      values             NE_idle       update             
   Animation          ��L?                  value                                                                    times !          ��L>���>��?      transitions !        �?  �?  �?  �?      values                                      update                value                                                                    times !                transitions !        �?      values             NORTH       update             
   Animation          ��L?                  value                                                                    times !          ��L>���>��?      transitions !        �?  �?  �?  �?      values                                      update                value                                                                    times !                transitions !        �?      values             NW       update             
   Animation          ��L>                  value                                                                    times !                transitions !        �?      values                    update                value                                                                    times !                transitions !        �?      values             NW_idle       update             
   Animation          ��L>                  value                                                                    times !                transitions !        �?      values                    update                value                                                                    times !                transitions !        �?      values             N_idle       update             
   Animation             RUN       
   Animation          ��L?                  value                                                                    times !          ��L>���>��?      transitions !        �?  �?  �?  �?      values                                      update                value                                                                    times !                transitions !        �?      values             SE       update             
   Animation          ��L>                  value                                                                    times !                transitions !        �?      values                    update                value                                                                    times !                transitions !        �?      values             SE_idle       update             
   Animation          ��L?                  value                                                                    times !          ��L>���>��?      transitions !        �?  �?  �?  �?      values                                      update                value                                                                    times !                transitions !        �?      values             SOUTH       update             
   Animation          ��L?                  value                                                                    times !          ��L>���>��?      transitions !        �?  �?  �?  �?      values                                      update                value                                                                    times !                transitions !        �?      values             SW       update             
   Animation          ��L>                  value                                                                    times !                transitions !        �?      values                    update                value                                                                    times !                transitions !        �?      values             SW_idle       update             
   Animation          ��L>                  value                                                                    times !                transitions !        �?      values                    update                value                                                                    times !                transitions !        �?      values             S_idle       update             
   Animation          ��L?                  value                                                                    times !          ��L>���>��?      transitions !        �?  �?  �?  �?      values                                      update                value                                                                    times !                transitions !        �?      values             WEST       update             
   Animation          ��L>                  value                                                                    times !                transitions !        �?      values                    update                value                                                                    times !                transitions !        �?      values             W_idle       update                AnimationLibrary                    EAST       *         E_idle       +         NE       ,         NE_idle       -         NORTH       .         NW       /         NW_idle       0         N_idle       1         RUN       2         SE       3         SE_idle       4         SOUTH       5         SW       6         SW_idle       7         S_idle       8         WEST       9         W_idle       :            AnimationNodeAnimation       ,      W_idle          AnimationNodeAnimation       ,      E_idle          AnimationNodeAnimation       ,      S_idle          AnimationNodeAnimation       ,      N_idle          AnimationNodeAnimation       ,      SW_idle          AnimationNodeAnimation       ,      NW_idle          AnimationNodeAnimation       ,      NE_idle          AnimationNodeAnimation       ,      SE_idle          AnimationNodeBlendSpace2D    #         <   $   
     ��    %         =   &   
     �?    '         >   (   
         �?)         ?   *   
         ��+         @   ,   
     ��  �?-         A   .   
     ��  ��/         B   0   
     �?  ��1         C   2   
     �?  �?8                  AnimationNodeAnimation       ,      SOUTH          AnimationNodeAnimation       ,      EAST          AnimationNodeAnimation       ,      NORTH          AnimationNodeAnimation       ,      WEST          AnimationNodeAnimation       ,      SW          AnimationNodeAnimation       ,      NW          AnimationNodeAnimation       ,      NE          AnimationNodeAnimation       ,      SE          AnimationNodeBlendSpace2D    #         E   $   
         �?%         F   &   
     �?    '         G   (   
         ��)         H   *   
     ��    +         I   ,   
     ��  �?-         J   .   
     ��  ��/         K   0   
     �?  ��1         L   2   
     �?  �?8               $   AnimationNodeStateMachineTransition    ?               $   AnimationNodeStateMachineTransition    ?         @   ,      is_walking       $   AnimationNodeStateMachineTransition    ?         @   ,      idle          AnimationNodeStateMachine 	   E      G         D   H   
    ��C  �BI      K         M   L   
    �+D  �BM      	         Start       IDLE       N         IDLE       WALK       O         WALK       IDLE       P   N   
     PA  �         PackedScene    O      	         names "         world    Node2D    CharacterBody2D    script    SPEED    acceleration 	   FRICTION    AnimatedSprite2D    sprite_frames 
   animation    speed_scale    CollisionShape2D    shape    AnimationPlayer 
   libraries    AnimationTree 
   tree_root    anim_player    parameters/conditions/idle !   parameters/conditions/is_walking    parameters/IDLE/blend_position    parameters/WALK/blend_position 
   dashtimer 
   wait_time 	   one_shot    Timer    _on_dashtimer_timeout    timeout    	   variants                          (   ,      NW_idle       @      )                      ;         Q                      
   �Q���}�
   :���ڪ?)   
ףp=
 @            node_count             nodes     S   ��������       ����                      ����                                             ����         	      
                       ����                          ����                          ����                  	      	      
                          ����                         conn_count             conns                                     node_paths              editable_instances              version             RSRC    extends Area2D

enum Pullstate{idle,pulling,arrowshot,reset}

var pullbackstate
var line

func shoot():
	if Input.is_action_just_pressed("shoot"):
		var mousepos = get_global_mouse_position()
		print(mousepos)
		
# Called when the node enters the scene tree for the first time.
func _ready():
	line = $Line2D
	pullbackstate = pullbackstate.idle


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match Pullstate:
		pullbackstate.idle:
			pass
		pullbackstate.pulling:
			if Input.is_action_just_pressed("shoot"):
				var mousepos = get_global_mouse_position()
				print(mousepos)
		pullbackstate.arrowshot:
			pass
		pullbackstate.reset:
			pass
	pass
  RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://Area2D.gd ��������
   Texture2D    res://icon.svg ���!.�p      local://PackedScene_g6f4o 0         PackedScene          	         names "         Arrow    script    Node2D 	   Sprite2D 	   position    scale    texture    VisibleOnScreenNotifier2D 	   Camera2D    zoom    Line2D 	   pullarea    Area2D    CollisionShape2D    	   variants                 
     �� ��
      >   >         
     @@  @@      node_count             nodes     ;   ��������       ����                            ����                                       ����                      ����   	                  
   
   ����                      ����                     ����              conn_count              conns               node_paths              editable_instances              version             RSRC         extends CharacterBody2D

@onready var dashtimer = $dashtimer
@onready var animationtree = $AnimationTree
@onready var direction = Vector2.ZERO
@export var SPEED = 100.0
@export var acceleration = 20
@export var FRICTION = 5

func _physics_process(delta):
	direction = Input.get_vector("left", "right", "up", "down"). normalized()
	if direction:
		velocity = velocity.move_toward(SPEED * direction, acceleration)
		set_walking(true)
		update_blend_position()
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
		set_walking(false)
	move_and_slide()


func set_walking(value):
	animationtree["parameters/conditions/is_walking"] = value
	animationtree["parameters/conditions/idle"] = not value
	
func update_blend_position():
	animationtree["parameters/IDLE/blend_position"] = direction
	animationtree["parameters/WALK/blend_position"] = direction
	
   extends Node2D

var can_dash = true
var dash_delay = 0.4

@onready var Dashtimer = $dashtimer

func start_dash(duration): 
	Dashtimer.wait_time = duration
	Dashtimer.start()
	
func is_dashing():
	return Dashtimer.is_stopped()
	
func end_dash():
	can_dash = false
	await(get_tree().create_timer(dash_delay).call('timeout')


func _on_dashtimer_timeout():
	end_dash()
  RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://dash.gd ��������      local://PackedScene_205q2          PackedScene          	         names "         dash    script    Node2D 
   dashtimer 
   wait_time    Timer    _on_dashtimer_timeout    timeout    	   variants                 )   �z�G��?      node_count             nodes        ��������       ����                            ����                   conn_count             conns                                      node_paths              editable_instances              version             RSRC RSRC                    AudioBusLayout            ��������                                            	      resource_local_to_scene    resource_name    bus/0/name    bus/0/solo    bus/0/mute    bus/0/bypass_fx    bus/0/volume_db    bus/0/send    script           local://AudioBusLayout_j8ce6 =         AudioBusLayout          RSRCGST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�m�m۬�}�p,��5xi�d�M���)3��$�V������3���$G�$2#�Z��v{Z�lێ=W�~� �����d�vF���h���ڋ��F����1��ڶ�i�엵���bVff3/���Vff���Ҿ%���qd���m�J�}����t�"<�,���`B �m���]ILb�����Cp�F�D�=���c*��XA6���$
2#�E.@$���A.T�p )��#L��;Ev9	Б )��D)�f(qA�r�3A�,#ѐA6��npy:<ƨ�Ӱ����dK���|��m�v�N�>��n�e�(�	>����ٍ!x��y�:��9��4�C���#�Ka���9�i]9m��h�{Bb�k@�t��:s����¼@>&�r� ��w�GA����ը>�l�;��:�
�wT���]�i]zݥ~@o��>l�|�2�Ż}�:�S�;5�-�¸ߥW�vi�OA�x��Wwk�f��{�+�h�i�
4�˰^91��z�8�(��yޔ7֛�;0����^en2�2i�s�)3�E�f��Lt�YZ���f-�[u2}��^q����P��r��v��
�Dd��ݷ@��&���F2�%�XZ!�5�.s�:�!�Њ�Ǝ��(��e!m��E$IQ�=VX'�E1oܪì�v��47�Fы�K챂D�Z�#[1-�7�Js��!�W.3׹p���R�R�Ctb������y��lT ��Z�4�729f�Ј)w��T0Ĕ�ix�\�b�9�<%�#Ɩs�Z�O�mjX �qZ0W����E�Y�ڨD!�$G�v����BJ�f|pq8��5�g�o��9�l�?���Q˝+U�	>�7�K��z�t����n�H�+��FbQ9���3g-UCv���-�n�*���E��A�҂
�Dʶ� ��WA�d�j��+�5�Ȓ���"���n�U��^�����$G��WX+\^�"�h.���M�3�e.
����MX�K,�Jfѕ*N�^�o2��:ՙ�#o�e.
��p�"<W22ENd�4B�V4x0=حZ�y����\^�J��dg��_4�oW�d�ĭ:Q��7c�ڡ��
A>��E�q�e-��2�=Ϲkh���*���jh�?4�QK��y@'�����zu;<-��|�����Y٠m|�+ۡII+^���L5j+�QK]����I �y��[�����(}�*>+���$��A3�EPg�K{��_;�v�K@���U��� gO��g��F� ���gW� �#J$��U~��-��u���������N�@���2@1��Vs���Ŷ`����Dd$R�":$ x��@�t���+D�}� \F�|��h��>�B�����B#�*6��  ��:���< ���=�P!���G@0��a��N�D�'hX�׀ "5#�l"j߸��n������w@ K�@A3�c s`\���J2�@#�_ 8�����I1�&��EN � 3T�����MEp9N�@�B���?ϓb�C��� � ��+�����N-s�M�  ��k���yA 7 �%@��&��c��� �4�{� � �����"(�ԗ�� �t�!"��TJN�2�O~� fB�R3?�������`��@�f!zD��%|��Z��ʈX��Ǐ�^�b��#5� }ى`�u�S6�F�"'U�JB/!5�>ԫ�������/��;	��O�!z����@�/�'�F�D"#��h�a �׆\-������ Xf  @ �q�`��鎊��M��T�� ���0���}�x^�����.�s�l�>�.�O��J�d/F�ě|+^�3�BS����>2S����L�2ޣm�=�Έ���[��6>���TъÞ.<m�3^iжC���D5�抺�����wO"F�Qv�ږ�Po͕ʾ��"��B��כS�p�
��E1e�������*c�������v���%'ž��&=�Y�ް>1�/E������}�_��#��|������ФT7׉����u������>����0����緗?47�j�b^�7�ě�5�7�����|t�H�Ե�1#�~��>�̮�|/y�,ol�|o.��QJ rmϘO���:��n�ϯ�1�Z��ը�u9�A������Yg��a�\���x���l���(����L��a��q��%`�O6~1�9���d�O{�Vd��	��r\�՜Yd$�,�P'�~�|Z!�v{�N�`���T����3?DwD��X3l �����*����7l�h����	;�ߚ�;h���i�0�6	>��-�/�&}% %��8���=+��N�1�Ye��宠p�kb_����$P�i�5�]��:��Wb�����������ě|��[3l����`��# -���KQ�W�O��eǛ�"�7�Ƭ�љ�WZ�:|���є9�Y5�m7�����o������F^ߋ������������������Р��Ze�>�������������?H^����&=����~�?ڭ�>���Np�3��~���J�5jk�5!ˀ�"�aM��Z%�-,�QU⃳����m����:�#��������<�o�����ۇ���ˇ/�u�S9��������ٲG}��?~<�]��?>��u��9��_7=}�����~����jN���2�%>�K�C�T���"������Ģ~$�Cc�J�I�s�? wڻU���ə��KJ7����+U%��$x�6
�$0�T����E45������G���U7�3��Z��󴘶�L�������^	dW{q����d�lQ-��u.�:{�������Q��_'�X*�e�:�7��.1�#���(� �k����E�Q��=�	�:e[����u��	�*�PF%*"+B��QKc˪�:Y��ـĘ��ʴ�b�1�������\w����n���l镲��l��i#����!WĶ��L}rեm|�{�\�<mۇ�B�HQ���m�����x�a�j9.�cRD�@��fi9O�.e�@�+�4�<�������v4�[���#bD�j��W����֢4�[>.�c�1-�R�����N�v��[�O�>��v�e�66$����P
�HQ��9���r�	5FO� �<���1f����kH���e�;����ˆB�1C���j@��qdK|
����4ŧ�f�Q��+�     [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://l0k4de4x60pp"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 RSRC                    PackedScene            ��������                                            P      AnimatedSprite2D    frame 
   animation    ..    AnimationPlayer    resource_local_to_scene    resource_name    atlas    region    margin    filter_clip    script    animations    custom_solver_bias    radius    length 
   loop_mode    step    tracks/0/type    tracks/0/imported    tracks/0/enabled    tracks/0/path    tracks/0/interp    tracks/0/loop_wrap    tracks/0/keys    tracks/1/type    tracks/1/imported    tracks/1/enabled    tracks/1/path    tracks/1/interp    tracks/1/loop_wrap    tracks/1/keys    _data 
   play_mode    auto_triangles    blend_point_0/node    blend_point_0/pos    blend_point_1/node    blend_point_1/pos    blend_point_2/node    blend_point_2/pos    blend_point_3/node    blend_point_3/pos    blend_point_4/node    blend_point_4/pos    blend_point_5/node    blend_point_5/pos    blend_point_6/node    blend_point_6/pos    blend_point_7/node    blend_point_7/pos 
   min_space 
   max_space    snap    x_label    y_label    blend_mode    sync    xfade_time    xfade_curve    reset 	   priority    switch_mode    advance_mode    advance_condition    advance_expression    state_machine_type    allow_transition_to_self    reset_ends    states/End/node    states/End/position    states/IDLE/node    states/IDLE/position    states/Start/node    states/Start/position    states/WALK/node    states/WALK/position    transitions    graph_offset 	   _bundled       Script    res://CharacterBody2D.gd ��������
   Texture2D #   res://assets/spritesheet_50x50.png ɭ��U��"S      local://AtlasTexture_hmdom          local://AtlasTexture_davdh Y         local://AtlasTexture_8guw3 �         local://AtlasTexture_ani0k �         local://AtlasTexture_4ujp5 (         local://AtlasTexture_84mrg m         local://AtlasTexture_0ckyh �         local://AtlasTexture_1ino2 �         local://AtlasTexture_ynucs <         local://AtlasTexture_h4xrj �         local://AtlasTexture_io7db �         local://AtlasTexture_05kjs          local://AtlasTexture_3f7mi P         local://AtlasTexture_57lwx �         local://AtlasTexture_nnw4d �         local://AtlasTexture_eqo7p          local://AtlasTexture_krl08 d         local://AtlasTexture_n654n �         local://AtlasTexture_ppdcw �         local://AtlasTexture_kag83 3         local://AtlasTexture_6q3c0 x         local://AtlasTexture_jfwco �         local://AtlasTexture_cl0te          local://AtlasTexture_4x331 G         local://AtlasTexture_bseih �         local://AtlasTexture_n3hwr �         local://AtlasTexture_r7cmk          local://AtlasTexture_24u5r [         local://AtlasTexture_yikve �         local://AtlasTexture_6huk4 �         local://AtlasTexture_5j28u *         local://AtlasTexture_fj6md o         local://AtlasTexture_sp1qh �         local://AtlasTexture_dcbmp �         local://AtlasTexture_bi00c >         local://AtlasTexture_yaao5 �         local://AtlasTexture_c35pg �         local://AtlasTexture_15udd          local://AtlasTexture_m3y11 R         local://AtlasTexture_30d4k �         local://SpriteFrames_p5q5m �         local://CircleShape2D_ewifb �.         local://Animation_c2y1s �.         local://Animation_mykxi 1         local://Animation_oqki7 �2         local://Animation_b0lpk �4         local://Animation_dkox7 �6         local://Animation_gteyb �8         local://Animation_5frmo �:         local://Animation_nqli8 �<         local://Animation_kk1qe �>         local://Animation_5g153 �>         local://Animation_1p8yk �@         local://Animation_7tche �B         local://Animation_fyqub �D         local://Animation_awhlf �F         local://Animation_8l3a8 �H         local://Animation_0ap51 yJ         local://Animation_3wvwa �L         local://AnimationLibrary_rq85s aN      %   local://AnimationNodeAnimation_gjii5 DP      %   local://AnimationNodeAnimation_m8tev ~P      %   local://AnimationNodeAnimation_30hbx �P      %   local://AnimationNodeAnimation_hurdd �P      %   local://AnimationNodeAnimation_ev065 ,Q      %   local://AnimationNodeAnimation_qhmem gQ      %   local://AnimationNodeAnimation_he7oe �Q      %   local://AnimationNodeAnimation_kvyn4 �Q      (   local://AnimationNodeBlendSpace2D_uyp4r R      %   local://AnimationNodeAnimation_0yd3n NS      %   local://AnimationNodeAnimation_sh3nn �S      %   local://AnimationNodeAnimation_smaih �S      %   local://AnimationNodeAnimation_f7cr7 �S      %   local://AnimationNodeAnimation_i7pyy 0T      %   local://AnimationNodeAnimation_su7wg fT      %   local://AnimationNodeAnimation_8ogfy �T      %   local://AnimationNodeAnimation_jitcm �T      (   local://AnimationNodeBlendSpace2D_7v3ju U      2   local://AnimationNodeStateMachineTransition_0r27a >V      2   local://AnimationNodeStateMachineTransition_keyu5 ~V      2   local://AnimationNodeStateMachineTransition_652jh �V      (   local://AnimationNodeStateMachine_83wpj &W         local://PackedScene_b0ftj /X         AtlasTexture                            C  HB  HB         AtlasTexture                        HB  C  HB  HB         AtlasTexture                        C  C  HB  HB         AtlasTexture                        �B  C  HB  HB         AtlasTexture                        HC  C  HB  HB         AtlasTexture                            HC  HB  HB         AtlasTexture                        HB  HC  HB  HB         AtlasTexture                        �B  HC  HB  HB         AtlasTexture                        C  HC  HB  HB         AtlasTexture                        HC  HC  HB  HB         AtlasTexture                                HB  HB         AtlasTexture                        HB      HB  HB         AtlasTexture                        �B      HB  HB         AtlasTexture                        C      HB  HB         AtlasTexture                            �C  HB  HB         AtlasTexture                        HB  �C  HB  HB         AtlasTexture                        �B  �C  HB  HB         AtlasTexture                        C  �C  HB  HB         AtlasTexture                        HC  �C  HB  HB         AtlasTexture                        HC      HB  HB         AtlasTexture                            �B  HB  HB         AtlasTexture                        HB  �B  HB  HB         AtlasTexture                        �B  �B  HB  HB         AtlasTexture                        C  �B  HB  HB         AtlasTexture                        HC  �B  HB  HB         AtlasTexture                            HB  HB  HB         AtlasTexture                        HB  HB  HB  HB         AtlasTexture                        �B  HB  HB  HB         AtlasTexture                        C  HB  HB  HB         AtlasTexture                            zC  HB  HB         AtlasTexture                        HB  zC  HB  HB         AtlasTexture                        �B  zC  HB  HB         AtlasTexture                        C  zC  HB  HB         AtlasTexture                        HC  zC  HB  HB         AtlasTexture                        HC  HB  HB  HB         AtlasTexture                            �C  HB  HB         AtlasTexture                        dB  �C  @B  HB         AtlasTexture                        C  �C  HB  HB         AtlasTexture                        �B  �C  HB  HB         AtlasTexture                        IC  �C  @B  HB         SpriteFrames                         name ,      EAST       speed      �@      loop             frames                   texture              	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            name ,      E_idle       speed      �@      loop             frames                   texture             	   duration      �?            name ,      NE       speed      �@      loop             frames                   texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            name ,      NE_idle       speed      �@      loop             frames                   texture       	      	   duration      �?            name ,      NORTH       speed      �@      loop             frames                   texture       
      	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            name ,      NW       speed      �@      loop             frames                   texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            name ,      NW_idle       speed      �@      loop             frames                   texture             	   duration      �?            name ,      N_idle       speed      �@      loop             frames                   texture             	   duration      �?            name ,      SE       speed      �@      loop             frames                   texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            name ,      SE_idle       speed      �@      loop             frames                   texture             	   duration      �?            name ,      SOUTH       speed      �@      loop             frames                   texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            name ,      SW       speed      �@      loop             frames                   texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            texture              	   duration      �?            name ,      SW_idle       speed      �@      loop             frames                   texture       !      	   duration      �?            name ,      S_idle       speed      �@      loop             frames                   texture       "      	   duration      �?            name ,      WEST       speed      �@      loop             frames                   texture       #      	   duration      �?            texture       $      	   duration      �?            texture       %      	   duration      �?            texture       &      	   duration      �?            name ,      W_idle       speed      �@      loop             frames                   texture       '      	   duration      �?         CircleShape2D          
   Animation          ��L?                  value                                                                    times !          ��L>���>��?      transitions !        �?  �?  �?  �?      values                                      update                value                                                                    times !                transitions !        �?      values             EAST       update             
   Animation          ��L>                  value                                                                    times !                transitions !        �?      values                    update                value                                                                    times !                transitions !        �?      values             E_idle       update             
   Animation          ��L?                  value                                                                    times !          ��L>���>��?      transitions !        �?  �?  �?  �?      values                                      update                value                                                                    times !                transitions !        �?      values             NE       update             
   Animation          ��L>                  value                                                                    times !                transitions !        �?      values                    update                value                                                                    times !                transitions !        �?      values             NE_idle       update             
   Animation          ��L?                  value                                                                    times !          ��L>���>��?      transitions !        �?  �?  �?  �?      values                                      update                value                                                                    times !                transitions !        �?      values             NORTH       update             
   Animation          ��L?                  value                                                                    times !          ��L>���>��?      transitions !        �?  �?  �?  �?      values                                      update                value                                                                    times !                transitions !        �?      values             NW       update             
   Animation          ��L>                  value                                                                    times !                transitions !        �?      values                    update                value                                                                    times !                transitions !        �?      values             NW_idle       update             
   Animation          ��L>                  value                                                                    times !                transitions !        �?      values                    update                value                                                                    times !                transitions !        �?      values             N_idle       update             
   Animation             RUN       
   Animation          ��L?                  value                                                                    times !          ��L>���>��?      transitions !        �?  �?  �?  �?      values                                      update                value                                                                    times !                transitions !        �?      values             SE       update             
   Animation          ��L>                  value                                                                    times !                transitions !        �?      values                    update                value                                                                    times !                transitions !        �?      values             SE_idle       update             
   Animation          ��L?                  value                                                                    times !          ��L>���>��?      transitions !        �?  �?  �?  �?      values                                      update                value                                                                    times !                transitions !        �?      values             SOUTH       update             
   Animation          ��L?                  value                                                                    times !          ��L>���>��?      transitions !        �?  �?  �?  �?      values                                      update                value                                                                    times !                transitions !        �?      values             SW       update             
   Animation          ��L>                  value                                                                    times !                transitions !        �?      values                    update                value                                                                    times !                transitions !        �?      values             SW_idle       update             
   Animation          ��L>                  value                                                                    times !                transitions !        �?      values                    update                value                                                                    times !                transitions !        �?      values             S_idle       update             
   Animation          ��L?                  value                                                                    times !          ��L>���>��?      transitions !        �?  �?  �?  �?      values                                      update                value                                                                    times !                transitions !        �?      values             WEST       update             
   Animation          ��L>                  value                                                                    times !                transitions !        �?      values                    update                value                                                                    times !                transitions !        �?      values             W_idle       update                AnimationLibrary                    EAST       *         E_idle       +         NE       ,         NE_idle       -         NORTH       .         NW       /         NW_idle       0         N_idle       1         RUN       2         SE       3         SE_idle       4         SOUTH       5         SW       6         SW_idle       7         S_idle       8         WEST       9         W_idle       :            AnimationNodeAnimation       ,      W_idle          AnimationNodeAnimation       ,      E_idle          AnimationNodeAnimation       ,      S_idle          AnimationNodeAnimation       ,      N_idle          AnimationNodeAnimation       ,      SW_idle          AnimationNodeAnimation       ,      NW_idle          AnimationNodeAnimation       ,      NE_idle          AnimationNodeAnimation       ,      SE_idle          AnimationNodeBlendSpace2D    #         <   $   
     ��    %         =   &   
     �?    '         >   (   
         �?)         ?   *   
         ��+         @   ,   
     ��  �?-         A   .   
     ��  ��/         B   0   
     �?  ��1         C   2   
     �?  �?8                  AnimationNodeAnimation       ,      SOUTH          AnimationNodeAnimation       ,      EAST          AnimationNodeAnimation       ,      NORTH          AnimationNodeAnimation       ,      WEST          AnimationNodeAnimation       ,      SW          AnimationNodeAnimation       ,      NW          AnimationNodeAnimation       ,      NE          AnimationNodeAnimation       ,      SE          AnimationNodeBlendSpace2D    #         E   $   
         �?%         F   &   
     �?    '         G   (   
         ��)         H   *   
     ��    +         I   ,   
     ��  �?-         J   .   
     ��  ��/         K   0   
     �?  ��1         L   2   
     �?  �?8               $   AnimationNodeStateMachineTransition    ?               $   AnimationNodeStateMachineTransition    ?         @   ,      is_walking       $   AnimationNodeStateMachineTransition    ?         @   ,      idle          AnimationNodeStateMachine 	   E      G         D   H   
    ��C  �BI      K         M   L   
    �+D  �BM      	         Start       IDLE       N         IDLE       WALK       O         WALK       IDLE       P   N   
     PA  �         PackedScene    O      	         names "         world    Node2D    CharacterBody2D    script    AnimatedSprite2D    sprite_frames 
   animation    speed_scale    CollisionShape2D    shape    AnimationPlayer 
   libraries    AnimationTree 
   tree_root    anim_player    parameters/conditions/idle !   parameters/conditions/is_walking    parameters/IDLE/blend_position    parameters/WALK/blend_position 
   dashtimer 
   wait_time 	   one_shot    Timer 	   Camera2D    zoom    _on_dashtimer_timeout    timeout    	   variants                       (   ,      NW_idle       @      )                      ;         Q                      
   �Q���}�
   :���ڪ?)   
ףp=
 @      
     @@  @@      node_count             nodes     V   ��������       ����                      ����                           ����                                      ����   	                 
   
   ����                          ����                              	      
                    ����                                ����                   conn_count             conns                                     node_paths              editable_instances              version             RSRC  [remap]

path="res://.godot/exported/133200997/export-bdd9c6d2500d8463edc5602402e719bf-dash.scn"
               [remap]

path="res://.godot/exported/133200997/export-7936cb3314e92baa208a95fc6f151298-node_2d.scn"
            [remap]

path="res://.godot/exported/133200997/export-1dfc2c274347e11dc35451b9b61eaa50-area_2d.scn"
            [remap]

path="res://.godot/exported/133200997/export-d9412acfc29a579e2cb27840aeb3088c-dash.scn"
               [remap]

path="res://.godot/exported/133200997/export-19246414aa9fb561ced4b8dce477acec-default_bus_layout.res"
 [remap]

path="res://.godot/exported/133200997/export-362256a061aa8890e9a1e558b11e5ec3-node_2d.scn"
            list=Array[Dictionary]([])
     <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 814 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H446l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z" fill="#478cbf"/><path d="M483 600c0 34 58 34 58 0v-86c0-34-58-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
           
   0X�Ί�U   res://assets/bow.pngɭ��U��""   res://assets/spritesheet_50x50.png�~�{�4,   res://assets/spritesheet_50x50_fixed (1).pngW��V�L   res://scenes/dash.tscntF0�A�4   res://scenes/node_2d.tscn�k���4d   res://area_2d.tscn�Zu�   res://dash.tscnX��;�t:   res://default_bus_layout.tres���!.�p   res://icon.svg�P�����y   res://node_2d.tscn     ECFG      application/config/name         Alloys adventure   application/run/main_scene         res://node_2d.tscn     application/config/features$   "         4.2    Forward Plus       application/config/icon         res://icon.svg     editor_plugins/enabled,   "         res://addons/AS2P/plugin.cfg       input/up�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script      
   input/down�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode    s      echo          script      
   input/left�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    a      echo          script         input/right�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script      
   input/dash�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script         input/shoot�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask           position              global_position               factor       �?   button_index         canceled          pressed           double_click          script      9   rendering/textures/canvas_textures/default_texture_filter                    