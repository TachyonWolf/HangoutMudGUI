extends Control
class_name TopBar

signal save_reqested
signal refresh_reqested

const save_id = 1
const refresh_id = 6
const exit_id = 9999

@export
var file_dropdown : MenuButton

func _ready():
	file_dropdown.get_popup().add_item("Refresh", refresh_id)
	file_dropdown.get_popup().add_item("Save World", save_id)
	file_dropdown.get_popup().add_item("Exit", exit_id)
	file_dropdown.get_popup().id_pressed.connect(option_pressed)

func option_pressed(id):
	if(id == save_id):
		save_reqested.emit()
	if(id == refresh_id):
		refresh_reqested.emit()
	elif(id == exit_id):
		get_tree().quit()
