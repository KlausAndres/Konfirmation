extends Control

onready var AnimationPlayer = $AnimationPlayer
onready var Sidebar = $HBoxContainer/Sidebar
onready var ImageContainer = $HBoxContainer/Body/Content/ImageViewer/Image

var images : Array = [preload("res://assets/img/Bild1.JPG"), preload("res://assets/img/Bild2.JPG"),
						preload("res://assets/img/Bild3.JPG"), preload("res://assets/img/Bild4.JPG")]
var image_index : int = 0

const COLOR = {'dark': '#147874', 'light': '#B1CDBD', 
	'white': '#FFFFFF', 'background': '#BEAA90'}
			
func _ready():
	Sidebar.rect_min_size = Vector2(70, 0)
	_hide_Navitems_label()
	_update_image()
	
func _update_image():
	ImageContainer.set_texture(images[image_index % len(images)])


	
func _on_Main_resized():
	$HBoxContainer/Body/TopBar/Titlebar/WinSize.text = String(get_viewport().size)
	_update_scale()

func _update_scale():
	var scale
	var width = get_viewport().size.x
	if width > 1000:
		scale = 1.0
	elif width <= 1000:
		scale = 0.80
	get_tree().set_screen_stretch(0, 4, Vector2(100, 100), scale)


func _on_ToggleButton_gui_input(event):
	if event is InputEventMouseButton:
		if event.get_button_index() == 1 and event.is_pressed():
			if Sidebar.rect_min_size[0] == 70:
				AnimationPlayer.play("Sidebar_animation")
				_show_NavItems_label()
			else:
				_hide_Navitems_label()
				AnimationPlayer.play_backwards("Sidebar_animation")


func _show_NavItems_label():
	var navitems = get_tree().get_nodes_in_group('NavItem')
	for navitem in navitems:
		navitem.show_label()

	
func _hide_Navitems_label():
	var navitems = get_tree().get_nodes_in_group('NavItem')
	for navitem in navitems:
		navitem.hide_label()


func _on_ButtonLeft_pressed():
	image_index -= 1
	_update_image()


func _on_ButtonRight_pressed():
	image_index += 1
	_update_image()
