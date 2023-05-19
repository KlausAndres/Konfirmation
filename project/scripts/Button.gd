extends Button

export var button_text : String

func _ready():
	text = button_text


func _on_Button_button_down():
	$AnimationPlayer.play('grow')


func _on_Button_button_up():
	$AnimationPlayer.play_backwards('grow')
