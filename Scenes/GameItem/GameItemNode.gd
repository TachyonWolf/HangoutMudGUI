extends Node
class_name GameItemNode



@export
var game_item : GameItem

@export
var sprite : ImageTexture

@export 
var sub_items : Array[GameItemNode]

var parent_relationship : GameItem.ParentRelationship

func init(new_game_item : GameItem):
	if(!new_game_item):
		return
	#set name
	var inst_name = new_game_item.instance_name
	if(inst_name):
		name = new_game_item.instance_name
	else:
		name = new_game_item.item_name
	
	parent_relationship = new_game_item.parent_relationship
	game_item = new_game_item
	if(multiplayer.is_server()):
		if(game_item.sub_items):
			for content in game_item.sub_items:
				var new_node = ItemFactoryManager.make_item()
				add_child(new_node)
				sub_items.append(new_node)
				new_node.init(content)
	else:
		rpc_id(1, "request_sub_items")

func set_image():
	pass

func put_item_into(game_item):
	pass

func put_item_onto(game_item):
	pass

func drop_item(game_item):
	pass


#returns if the object could not be removed... this means respawn DOES count.
#func destory() -> bool:
#	if(game_item.tags.has("Imortal")):
#		Action Manager respawn me
#		return true
#	elif(game_item.tags.has("KeyItem") || game_item.tags.has("Indestrucable") ):
#		Don't break
#		return false
#	else:
#		drop all not breakables
#


func drop_all_items(destory_non_sturdy : bool):
	pass




@rpc(any_peer)
func request_sub_items():
	var requester_id = multiplayer.get_remote_sender_id()
	if(multiplayer.is_server()):
		print("Got request from:", str(requester_id))
		for item in sub_items:
			pass
