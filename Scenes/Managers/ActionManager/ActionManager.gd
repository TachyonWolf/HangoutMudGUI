extends Node


var actions : Array[Action] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	actions.append(AMake.new())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_valid_actions(subjects : Array[String]) -> Array[Action]:
	var valid_actions : Array[Action] = []
	for action in actions:
		if(action.can_preform(PlayerManager.player_node, subjects)):
			valid_actions.append(action)
	return valid_actions
