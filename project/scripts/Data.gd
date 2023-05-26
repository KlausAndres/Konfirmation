extends Node

# login sucessfull?
var login : bool = false

# maintain the user_data
# Klaus, Valerie
var user_data_input = [ [227087109, 'Lieber Papa,', 'singular', true],
						[3387954893, 'Liebe Familie Andres,', 'plural', false]
]

# stores the user data in a dictionary
var user_data : Dictionary

# Seebergen
var password = 925213237

# state of the game
enum state {SIGNIN, HOME, IMAGE_VIEWER, SETTINGS}
var app_state : int

var active_user

# stores the different versions of the home text
var home_text_data = {
	'guest_singular': '\n\nnoch immer denke ich sehr gern an meine Konfirmation zurück. Dadurch, dass du da warst, ist es für mich zu einem unvergesslichen Tag geworden.\n\nIch habe auf dieser Webseite einige Fotos eingestellt. Vielleicht hast Du ja Lust, in den Bildern zu stöbern und dich noch einmal an den Tag zu erinnern.\n\nVielen Dank noch einmal für alles!\n\nBis hoffentlich bald wieder\n\n\nDein Daniel', 
	'guest_plural': '\n\nnoch immer denke ich sehr gern an meine Konfirmation zurück. Dadurch, dass ihr da ward, ist es für mich zu einem unvergesslichen Tag geworden.\n\nIch habe auf dieser Webseite einige Fotos eingestellt. Vielleicht habt Ihr ja Lust, in den Bildern zu stöbern und euch noch einmal an den Tag zu erinnern.\n\nVielen Dank noch einmal für alles!\n\nBis hoffentlich bald wieder\n\n\nEuer Daniel',
	'no_guest_singular': '\n\nnoch immer denke ich sehr gern an meine Konfirmation zurück. Dadurch, dass du so lieb an mich gedacht hast, ist es für mich zu einem unvergesslichen Tag geworden.\n\n Ich habe auf dieser Webseite einige Fotos eingestellt. Vielleicht hast Du ja Lust, in den Bildern zu stöbern und dir einen Eindruck von dem Tag zu machen.\n\nVielen Dank noch einmal für alles!\n\nBis hoffentlich bald wieder\n\n\nDein Daniel',
	'no_guest_plural': '\n\nnoch immer denke ich sehr gern an meine Konfirmation zurück. Dadurch, dass ihr so lieb an mich gedacht habt, ist es für mich zu einem unvergesslichen Tag geworden.\n\n Ich habe auf dieser Webseite einige Fotos eingestellt. Vielleicht habt ihr ja Lust, in den Bildern zu stöbern und euch einen Eindruck von dem Tag zu machen.\n\nVielen Dank noch einmal für alles!\n\nBis hoffentlich bald wieder\n\n\nEuer Daniel'}

func _ready():
	_implement_user_data()


func _implement_user_data():
	# data structure user
	# {hash_user_name: {'welcome', 'adress', 'guest'}}
	for _user in user_data_input:
		user_data[_user[0]] = {'welcome': _user[1], 'adress': _user[2], 'guest': _user[3]}

func is_username_valid(_user_name) -> bool:
	if user_data.keys().has(hash(_user_name)):
		return true
	return false

func get_home_text() -> String:
	var home_text : String
	# singular / guest
	if user_data[active_user]['adress'] == 'singular' and user_data[active_user]['guest'] == true:
		home_text = user_data[active_user]['welcome'] + home_text_data['guest_singular']
	# plural / guest
	elif user_data[active_user]['adress'] == 'plural' and user_data[active_user]['guest'] == true:
		home_text = user_data[active_user]['welcome'] + home_text_data['guest_plural']
	# singular / no_guest
	elif user_data[active_user]['adress'] == 'singular' and user_data[active_user]['guest'] == false:
		home_text = user_data[active_user]['welcome'] + home_text_data['no_guest_singular']
	# singular / no_guest
	elif user_data[active_user]['adress'] == 'plural' and user_data[active_user]['guest'] == false:
		home_text = user_data[active_user]['welcome'] + home_text_data['no_guest_plural']
	return home_text

