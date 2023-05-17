extends Control

onready var AnimationPlayer = $AnimationPlayer
onready var Sidebar = $HBoxContainer/Sidebar



const COLOR = {'dark': '#147874', 'light': '#B1CDBD', 
	'white': '#FFFFFF', 'background': '#BEAA90'}
			
func _ready():
	Sidebar.rect_min_size = Vector2(70, 0)
	_hide_Navitems_label()
	$HBoxContainer/Body/Content/get_name.text = OS.get_name()
	$HBoxContainer/Body/Content/win_size.text = String(get_viewport().size)

	
func _process(_delta):
	$HBoxContainer/Body/Content/win_size.text = String(get_viewport().size)


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
