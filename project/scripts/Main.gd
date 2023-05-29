extends Control

onready var AnimationPlayer = $AnimationPlayer
onready var Sidebar = $HBoxContainer/Sidebar
onready var ImageContainer = $HBoxContainer/Body/Content/ImageViewer/MC/Image
onready var ImageViewer = $HBoxContainer/Body/Content/ImageViewer
onready var SignIn = $HBoxContainer/Body/Content/SignIn
onready var Home = $HBoxContainer/Body/Content/Home
onready var HomeText = $HBoxContainer/Body/Content/Home/MC_2/Text
onready var Header = $HBoxContainer/Body/TopBar/Titlebar/Header
onready var Settings = $HBoxContainer/Body/Content/Settings
onready var Username = $HBoxContainer/Body/Content/SignIn/VBC/VBC/HBC/Username
onready var Password = $HBoxContainer/Body/Content/SignIn/VBC/VBC/HBC/Password
onready var Status = $HBoxContainer/Body/Content/SignIn/VBC/VBC/Status

var images : Array = Data.img_konfi_camp
var image_index : int = 0

const COLOR = {'dark': '#147874', 'light': '#B1CDBD', 
	'white': '#FFFFFF', 'background': '#BEAA90'}
			
func _ready():
	Sidebar.rect_min_size = Vector2(70, 0)
	_hide_Navitems_label()
	_update_image()
	Data.app_state = Data.state.SIGNIN
	SignIn.visible = true
#	Data.active_user = 227087109
#	Data.login = true
#	HomeText.text = Data.get_home_text()	
#	Home.visible = true

	
func _update_image():
	ImageContainer.set_texture(images[image_index % len(images)])

func _on_Main_resized():
	_update_scale()


func _update_scale():
	$HBoxContainer/Body/Content/Settings/WindowSize.text = String(get_viewport().size)
	# pass 
	# var scale
	# var width = get_viewport().size.x
#	if width > 1000:
#		scale = 1.0
#	elif width <= 1000:
#		scale = 0.80
#	get_tree().set_screen_stretch(0, 4, Vector2(100, 100), scale)


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
	

func _on_KonfiCamp_item_activated():
	_hide_all_content()
	images = Data.img_konfi_camp
	image_index = 0
	_update_image()
	Header.text = 'Konfi-Camp'
	ImageViewer.visible = true
	

func _on_Kirche_item_activated():
	_hide_all_content()
	images = Data.img_kirche
	image_index = 0
	_update_image()
	Header.text = 'Kirche'
	ImageViewer.visible = true
	

func _on_Konfirmant_item_activated():
	_hide_all_content()
	images = Data.img_konfirmant
	image_index = 0
	_update_image()
	Header.text = 'Konfirmant'
	ImageViewer.visible = true


func _on_Feier_item_activated():
	_hide_all_content()
	images = Data.img_feier
	image_index = 0
	_update_image()
	Header.text = 'Feier'
	ImageViewer.visible = true


func _on_Gast_item_activated():
	_hide_all_content()
	images = Data.img_gaeste
	image_index = 0
	_update_image()
	Header.text = 'Gast'
	ImageViewer.visible = true

func _on_Location_item_activated():
	_hide_all_content()
	images = Data.img_location
	image_index = 0
	_update_image()
	Header.text = 'Location'
	ImageViewer.visible = true


func _on_Settings_item_activated():
	_hide_all_content()
	Header.text = 'Download'
	Settings.visible = true


func _on_OKButton_pressed():
	var _username = Username.text
	var _password = Password.text
	if  Data.is_username_valid(_username) and hash(_password) == Data.password:
		Data.login = true
		SignIn.visible = false
		Data.active_user = hash(_username)
		HomeText.text = Data.get_home_text()
		Home.visible = true
		Data.app_state = Data.state.HOME
	elif Data.is_username_valid(_username) == false and hash(_password) != Data.password:
		Status.text = 'Bitte Benutzernamen und Passwort prüfen'
		Username.show_error()
		Password.show_error()
	elif Data.is_username_valid(_username) == false:
		Status.text = 'Bitte Benutzernamen prüfen'
		Username.show_error()
	elif hash(_password) != Data.password:
		Status.text = 'Bitte Passwort prüfen'
		Password.show_error()

func _input(event):
	if event.is_action_pressed('ui_accept') and Data.app_state == Data.state.SIGNIN:
		_on_OKButton_pressed()



func _on_Button_pressed():
	var _value = OS.shell_open("https://drive.google.com/drive/folders/1nBL-hLX-BuoRAuwyPacCnz607kFAqWVE?usp=sharing")


