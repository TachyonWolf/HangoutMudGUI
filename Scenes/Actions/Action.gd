class_name Action
var action_name : String

var tags_required_for_actor := []
var tags_required_for_subjects := []
var display_name = "UNNAMED"

var min_subejcts := 1
var max_subjects := 1
var requires_actor = true
var admin_only = false

func can_preform(actor : GameItemNode, subjects : Array[String]) -> bool:
	if(subjects.size() > max_subjects ||  subjects.size() < min_subejcts):
		return false
	if(requires_actor && actor == null):
		return false
	
	#admin checks
	if(PlayerManager.admin_mode):
		return true
	elif(admin_only):
		return true
	
	#last checks
	return preform_check_logic(actor, subjects)


func preform(actor, subjects, arguments):
	pass

func preform_check_logic(actor : GameItemNode, subjects : Array[String]) -> bool:
	return true
