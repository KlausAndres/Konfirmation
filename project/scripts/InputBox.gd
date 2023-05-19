extends LineEdit


export var color_normal : Color
export var color_focus : Color
export var color_fonts : Color
export var placeholder : String


func _ready():
	placeholder_text = placeholder
	

func _on_InputBox_focus_entered():
	$AnimationPlayer.play('grow')
	hide_error()


func _on_InputBox_focus_exited():
	$AnimationPlayer.play_backwards('grow')


func show_error():
	theme.get_stylebox('normal', 'LineEdit').shadow_size = 8
	theme.get_stylebox('focus', 'LineEdit').shadow_size = 8
	
	
func hide_error():
	theme.get_stylebox('normal', 'LineEdit').shadow_size = 0
	theme.get_stylebox('focus', 'LineEdit').shadow_size = 0


func _on_InputBox_mouse_entered():
	theme.get_stylebox('normal', 'LineEdit').border_color = color_focus


func _on_InputBox_mouse_exited():
	theme.get_stylebox('normal', 'LineEdit').border_color = color_normal
