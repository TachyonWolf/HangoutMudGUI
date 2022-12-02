class_name Action
var action_name : String

var tags_required_for_actor := []
var tags_required_for_subjects := []

var min_subejcts := 1
var max_subjects := 1
var requires_actor = false

func can_preform(actor : GameItem, subjects : Array[GameItem]) -> bool:
	if(subjects.size() > max_subjects ||  subjects.size() < min_subejcts):
		return false
	if(requires_actor && actor == null):
		return false
	if(PlayerManager.admin_mode):
		return true
	return preform_check_logic(actor, subjects)


func preform(actor, subjects, arguments):
	pass

func preform_check_logic(actor : GameItem, subjects : Array[GameItem]) -> bool:
	return true
