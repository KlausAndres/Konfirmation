extends Node

# ---- LOGIN ----

# login sucessfull?
var login : bool = false

# maintain the user_data
var user_data_input = [ [2912368178, 'Lieber Daniel,', 'singular', true],
						[3387954893, 'Liebe Valerie,', 'singular', true],
						[229072012, 'Liebe Mama,', 'singular', true],
						[227087109, 'Lieber Papa,', 'singular', true],
						[2088963527, 'Liebe Bini,', 'singular', true],
						[193466821, 'Lieber Opa,', 'singular', true],
						[227317774, 'Liebe Astrid, lieber Andreas, liebe Lina, lieber Finn,', 'plural', true],
						[3558194242, 'Liebe Familie Schirmer,', 'plural', true],
						[3304740395, 'Liebe Tanja, lieber Oke, lieber Marvin,', 'plural', true],
						[223286155, 'Liebe Heike,', 'singular', true],
						[4239956604, 'Liebe Sarah, lieber Christoph, liebe Malin, lieber Jonne,', 'plural', false],
						[3573603586, 'Liebe Bente, lieber Gunnar, liebe Finja, liebe Sarah,', 'plural', false],
						[3167280139, 'Liebe Susanne, lieber Werner, liebe Sanna,', 'plural', false],
						[2989589168, 'Liebe Bärbel, lieber Klaus,', 'plural', false],
						[2774934251, 'Lieber Jan-Peter,', 'singular', false]
]

# stores the user data in a dictionary
var user_data : Dictionary

# stores the hash of the active user
var active_user

var password = 925213237


# ----- IMAGE DATA ----

var img_konfi_camp : Array = [preload("res://assets/img/KonfiCamp/KonfiCamp_01.JPG"), preload("res://assets/img/KonfiCamp/KonfiCamp_02.JPG"), preload("res://assets/img/KonfiCamp/KonfiCamp_03.JPG"),
							preload("res://assets/img/KonfiCamp/KonfiCamp_04.JPG"), preload("res://assets/img/KonfiCamp/KonfiCamp_05.JPG"), preload("res://assets/img/KonfiCamp/KonfiCamp_06.JPG"),
							preload("res://assets/img/KonfiCamp/KonfiCamp_07.JPG"), preload("res://assets/img/KonfiCamp/KonfiCamp_08.JPG"), preload("res://assets/img/KonfiCamp/KonfiCamp_09.JPG"),
							preload("res://assets/img/KonfiCamp/KonfiCamp_10.JPG"), preload("res://assets/img/KonfiCamp/KonfiCamp_11.JPG"), preload("res://assets/img/KonfiCamp/KonfiCamp_12.JPG"),
							preload("res://assets/img/KonfiCamp/KonfiCamp_13.JPG"), preload("res://assets/img/KonfiCamp/KonfiCamp_14.JPG"), preload("res://assets/img/KonfiCamp/KonfiCamp_15.JPG"),
							preload("res://assets/img/KonfiCamp/KonfiCamp_16.JPG"), preload("res://assets/img/KonfiCamp/KonfiCamp_17.JPG"), preload("res://assets/img/KonfiCamp/KonfiCamp_18.JPG"),
							preload("res://assets/img/KonfiCamp/KonfiCamp_19.JPG"), preload("res://assets/img/KonfiCamp/KonfiCamp_20.JPG"), preload("res://assets/img/KonfiCamp/KonfiCamp_21.JPG"),
							preload("res://assets/img/KonfiCamp/KonfiCamp_22.JPG"), preload("res://assets/img/KonfiCamp/KonfiCamp_23.JPG")]

var img_kirche : Array = [preload("res://assets/img/Kirche/Kirche_01.JPEG"), preload("res://assets/img/Kirche/Kirche_02.JPG"), preload("res://assets/img/Kirche/Kirche_03.JPEG"),
							preload("res://assets/img/Kirche/Kirche_04.JPEG"), preload("res://assets/img/Kirche/Kirche_05.JPEG"), preload("res://assets/img/Kirche/Kirche_06.JPG"),
							preload("res://assets/img/Kirche/Kirche_07.JPG")
]

var img_konfirmant : Array = [preload("res://assets/img/Konfirmant/Konfirmant_01.JPG"), preload("res://assets/img/Konfirmant/Konfirmant_02.JPEG"), preload("res://assets/img/Konfirmant/Konfirmant_03.JPG"),
							preload("res://assets/img/Konfirmant/Konfirmant_04.JPG"), preload("res://assets/img/Konfirmant/Konfirmant_05.JPG"), preload("res://assets/img/Konfirmant/Konfirmant_06.JPG"),
							preload("res://assets/img/Konfirmant/Konfirmant_07.JPG"), preload("res://assets/img/Konfirmant/Konfirmant_08.JPG"), preload("res://assets/img/Konfirmant/Konfirmant_09.JPG"),
							preload("res://assets/img/Konfirmant/Konfirmant_10.JPG"), preload("res://assets/img/Konfirmant/Konfirmant_11.JPG"), preload("res://assets/img/Konfirmant/Konfirmant_12.JPG"),
							preload("res://assets/img/Konfirmant/Konfirmant_13.JPG"), preload("res://assets/img/Konfirmant/Konfirmant_14.JPG"), preload("res://assets/img/Konfirmant/Konfirmant_15.JPG"),
							preload("res://assets/img/Konfirmant/Konfirmant_16.JPG"), preload("res://assets/img/Konfirmant/Konfirmant_17.JPG"), preload("res://assets/img/Konfirmant/Konfirmant_18.JPG"),
							preload("res://assets/img/Konfirmant/Konfirmant_19.JPG")]


var img_feier : Array = [preload("res://assets/img/Feier/Feier_01.JPEG"), preload("res://assets/img/Feier/Feier_02.JPG"), preload("res://assets/img/Feier/Feier_03.JPG"),
							preload("res://assets/img/Feier/Feier_04.JPG"), preload("res://assets/img/Feier/Feier_05.JPG"), preload("res://assets/img/Feier/Feier_06.JPG"),
							preload("res://assets/img/Feier/Feier_07.JPG"), preload("res://assets/img/Feier/Feier_09.JPEG"),
							preload("res://assets/img/Feier/Feier_10.JPEG"), preload("res://assets/img/Feier/Feier_11.JPEG"), preload("res://assets/img/Feier/Feier_12.JPEG"),
							preload("res://assets/img/Feier/Feier_13.JPEG"), preload("res://assets/img/Feier/Feier_14.JPEG"), preload("res://assets/img/Feier/Feier_15.JPEG"),
							preload("res://assets/img/Feier/Feier_16.JPEG"), preload("res://assets/img/Feier/Feier_17.JPG"), preload("res://assets/img/Feier/Feier_18.JPEG"),
							preload("res://assets/img/Feier/Feier_19.JPEG"), preload("res://assets/img/Feier/Feier_20.JPG"), preload("res://assets/img/Feier/Feier_21.JPG"),
							preload("res://assets/img/Feier/Feier_22.JPG"), preload("res://assets/img/Feier/Feier_23.JPG")]


var img_gaeste : Array = [preload("res://assets/img/Gäste/Gäste_01.JPG"), preload("res://assets/img/Gäste/Gäste_02.JPEG"), preload("res://assets/img/Gäste/Gäste_03.JPG"),
							preload("res://assets/img/Gäste/Gäste_04.JPG"), preload("res://assets/img/Gäste/Gäste_05.JPEG"), preload("res://assets/img/Gäste/Gäste_06.JPG"),
							preload("res://assets/img/Gäste/Gäste_07.JPEG"), preload("res://assets/img/Gäste/Gäste_08.JPEG"), preload("res://assets/img/Gäste/Gäste_09.JPEG"),
							preload("res://assets/img/Gäste/Gäste_10.JPEG")]

var img_location : Array = [preload("res://assets/img/Location/Location_01.JPEG"), preload("res://assets/img/Location/Location_02.JPEG"), preload("res://assets/img/Location/Location_03.JPEG"),
							preload("res://assets/img/Location/Location_04.JPEG"), preload("res://assets/img/Location/Location_05.JPEG"), preload("res://assets/img/Location/Location_06.JPEG"),
							preload("res://assets/img/Location/Location_07.JPG"), preload("res://assets/img/Location/Location_08.JPEG"), preload("res://assets/img/Location/Location_09.JPEG"),
							preload("res://assets/img/Location/Location_10.JPG"), preload("res://assets/img/Location/Location_11.JPEG"), preload("res://assets/img/Location/Location_12.JPEG"),
							preload("res://assets/img/Location/Location_13.JPEG"), preload("res://assets/img/Location/Location_14.JPEG"), preload("res://assets/img/Location/Location_15.JPEG"),
							preload("res://assets/img/Location/Location_16.JPEG"), preload("res://assets/img/Location/Location_17.JPEG")]


# state of the app
enum state {SIGNIN, HOME, IMAGE_VIEWER, SETTINGS}
var app_state : int



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

func _format_index_to_string (index : int) -> String:
	if index < 10:
		return "0" + String(index)
	else:
		return String(index)
	
