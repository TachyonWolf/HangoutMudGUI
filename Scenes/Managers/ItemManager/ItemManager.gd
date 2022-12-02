extends Node

var _items : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_item(game_item_node : GameItemNode):
	_items[game_item_node.uid] = game_item_node

func get_item(item_id) -> GameItemNode:
	if(_items.has(item_id)):
		return _items[item_id] as GameItemNode
	return null

func get_new_uid(new_game_item : GameItem) -> String:
	var base_name := new_game_item.instance_name
	if(base_name == null || base_name == ""):
		base_name = new_game_item.item_name
	var number := 1
	var id_name := base_name + "_1"
	while(_items.has(id_name)):
		number += 1
		id_name = base_name + "_" + str(number)
	return id_name
