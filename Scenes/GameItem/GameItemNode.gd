extends Node
class_name GameItemNode

signal data_updated

@export
var game_item : GameItem
var uid : String

@export
var sprite : ImageTexture

@export 
var sub_items : Array[GameItemNode]

var parent_relationship : GameItem.ParentRelationship

func init(new_game_item : GameItem):
	if(!new_game_item):
		return
	
	if(new_game_item.uid != null && new_game_item.uid != ""):
		uid = new_game_item.uid
	else:
		new_game_item.uid = ItemManager.get_new_uid(new_game_item)
		uid = new_game_item.uid
	
	name = uid
	
	parent_relationship = new_game_item.parent_relationship
	game_item = new_game_item
	
	ItemManager.add_item(self)
	
	if(multiplayer.is_server()):
		if(game_item.sub_items):
			for item_res in game_item.sub_items:
				make_child_node(item_res)
	else:
		rpc_id(1, "request_sub_items")
	
	data_updated.emit()

func make_child_node(item_res):
	var new_node = ItemFactoryManager.make_item()
	add_child(new_node)
	sub_items.append(new_node)
	new_node.init(item_res)

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
			var data = inst_to_dict(item.game_item)
			rpc_id(requester_id, "server_to_client_make_node", data)

@rpc(authority, call_remote, reliable, 5)
func server_to_client_make_node(item_data):
	var item_res : GameItem = dict_to_inst(item_data)
	make_child_node(item_res)
