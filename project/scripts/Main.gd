extends Control

# TODO
# - Wischgeste für die Bilder
# - UI-Scaling in den Settings
# - Autoscroll in den Settings

onready var AnimationPlayer = $AnimationPlayer
onready var Sidebar = $HBoxContainer/Sidebar
onready var ImageContainer = $HBoxContainer/Body/Content/ImageViewer/Image
onready var ImageViewer = $HBoxContainer/Body/Content/ImageViewer
onready var SignIn = $HBoxContainer/Body/Content/SignIn
onready var Home = $HBoxContainer/Body/Content/Home
onready var Header = $HBoxContainer/Body/TopBar/Titlebar/Header
onready var Settings = $HBoxContainer/Body/Content/Settings
onready var Username = $HBoxContainer/Body/Content/SignIn/Username
onready var Password = $HBoxContainer/Body/Content/SignIn/Password
onready var Status = $HBoxContainer/Body/Content/SignIn/Status

var images_konfirmant : Array = [preload("res://assets/img/Konfirmant/Konfirmant_01.JPG"), preload("res://assets/img/Konfirmant/Konfirmant_02.JPG"), preload("res://assets/img/Konfirmant/Konfirmant_03.JPG"), preload("res://assets/img/Konfirmant/Konfirmant_04.JPG"), preload("res://assets/img/Konfirmant/Konfirmant_05.JPEG")]

var images_gast : Array = [preload("res://assets/img/Gast/Gast_01.JPG"), preload("res://assets/img/Gast/Gast_02.JPG"), preload("res://assets/img/Gast/Gast_03.JPG"),]

var images_location : Array = [preload("res://assets/img/Location/Location_01.JPG"), preload("res://assets/img/Location/Location_02.JPEG"), preload("res://assets/img/Location/Location_03.JPEG"), preload("res://assets/img/Location/Location_04.JPEG"), preload("res://assets/img/Location/Location_05.JPEG")]

var images : Array = images_gast 
var image_index : int = 0

const COLOR = {'dark': '#147874', 'light': '#B1CDBD', 
	'white': '#FFFFFF', 'background': '#BEAA90'}
			
func _ready():
	Sidebar.rect_min_size = Vector2(70, 0)
	_hide_Navitems_label()
	_update_image()
	SignIn.visible = true
	# Home.visible = true
	
func _update_image():
	ImageContainer.set_texture(images[image_index % len(images)])

func _on_Main_resized():
	$HBoxContainer/Body/Content/Settings/WinSize.text = "Bildschirmgröße " + String(get_viewport().size)
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
		if event.get_button_index() == 1 and event.is_pressed() and Data.login:
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


func _hide_all_content():
	for content in [Home, ImageViewer, Settings, SignIn]:
		content.visible = false
	



func _on_Home_item_activated():
	_hide_all_content()
	Home.visible = true
	Header.text = 'Meine Konfirmation'
	

func _on_Konfirmant_item_activated():
	_hide_all_content()
	images = images_konfirmant
	image_index = 0
	_update_image()
	Header.text = 'Konfirmant'
	ImageViewer.visible = true
	

func _on_Gast_item_activated():
	_hide_all_content()
	images = images_gast
	image_index = 0
	_update_image()
	Header.text = 'Gast'
	ImageViewer.visible = true


func _on_Location_item_activated():
	_hide_all_content()
	images = images_location
	image_index = 0
	_update_image()
	Header.text = 'Location'
	ImageViewer.visible = true


func _on_Settings_item_activated():
	_hide_all_content()
	Header.text = 'Settings'
	Settings.visible = true


func _on_OKButton_pressed():
	if  Data.user_names.has(hash(Username.text)) and hash(Password.text) == Data.password:
		Data.login = true
		SignIn.visible = false
		Home.visible = true
	elif Data.user_names.has(hash(Username.text)) == false and hash(Password.text) != Data.password:
		Status.text = 'Bitte Benutzernamen und Passwort prüfen'
		Username.show_error()
		Password.show_error()
	elif Data.user_names.has(hash(Username.text)) == false:
		Status.text = 'Bitte Benutzernamen prüfen'
		Username.show_error()
	elif hash(Password.text) != Data.password:
		Status.text = 'Bitte Passwort prüfen'
		Password.show_error()
