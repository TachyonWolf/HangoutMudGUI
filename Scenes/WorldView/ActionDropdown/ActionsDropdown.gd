extends Control


@export
var Vbox : VBoxContainer

func build_actions_list(subjects : Array[String]):
	for child in Vbox.get_children():
		Vbox.remove_child(child)
	var act_list = ActionManager.get_valid_actions(subjects)
	for action in act_list:
		var new_button : Button = Button.new()
		new_button.text = action.display_name
		Vbox.add_child(new_button)
#		$Panel.add_child(new_button)
