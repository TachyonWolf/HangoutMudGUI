extends Control
@tool

var savegame_path = "user://test_world.tres"

@export
var main_view : WorldView
@export
var top_bar : TopBar

@export
var world_node : GameItemNode

func _ready():
#	var world_item = world_node.game_item;
#	print(world_node.game_item.item_name)
	top_bar.save_reqested.connect(save)
	top_bar.refresh_reqested.connect(refresh)
	if(multiplayer.is_server() && ResourceLoader.exists(savegame_path)):
		multiplayer.peer_connected.connect(play_joined)
		var world_res : GameItem 
		world_res = load(savegame_path)
		world_node.init(world_res)
		main_view.build_full_tree(world_node)
		print(world_res.instance_name)

func save():
	var world_item = world_node.game_item;
	ResourceSaver.save(world_item, savegame_path)

func refresh():
	main_view.build_full_tree(world_node)

func play_joined(id):
	var data = inst_to_dict(world_node.game_item)
	rpc_id(id, "world_data", data)

@rpc(authority, call_remote, reliable, 2)
func world_data(data):
	var world_res : GameItem = dict_to_inst(data)
	world_node.init(world_res)
	main_view.build_full_tree(world_node)
