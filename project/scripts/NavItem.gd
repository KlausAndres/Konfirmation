extends Control

export (StreamTexture) var icon
export (String) var label
export (bool) var active = false

# signal item_activated

func _ready():
	$Icon.texture = icon
	$Label.text = label
	_update_active_state()

	
func activate():
	active = true
	# item_activated.emit()
	_update_active_state()

	
func deactivate():
	active = false
	_update_active_state()

	
func _update_active_state():
	$ActiveSign.visible = active

func show_label():
	$Label.visible = true
	
func hide_label():
	$Label.visible = false

func _on_NavItem_mouse_entered():
	$Background.color = '#B1CDBD'


func _on_NavItem_mouse_exited():
	$Background.color = '#147874'

func _on_NavItem_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.get_button_index() == 1:
			# deactivate all items
			var navitems = get_tree().get_nodes_in_group('NavItem')
			for navitem in navitems:
				navitem.deactivate()
			activate()
