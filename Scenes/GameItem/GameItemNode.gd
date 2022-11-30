extends Node
class_name GameItemNode

enum CarriedOrContained
{
	Inside,
	On,
	Outmost
}

@export
var game_item : GameItem

@export
var sprite : ImageTexture

@export 
var contained_items : Array[GameItemNode]
@export
var covering_items : Array[GameItemNode]

@export
var carried_or_contained : CarriedOrContained

func init(new_game_item, inside_state):
	if(!new_game_item):
		return
	carried_or_contained = inside_state
	game_item = new_game_item
	if(game_item.contents):
		for content in game_item.contents:
			var new_node = ItemFactoryManager.make_item()
			contained_items.append(new_node)
			new_node.add_child(new_node)
			new_node.init(content, CarriedOrContained.Inside)
	if(game_item.coverings):
		for covering in game_item.coverings:
			var new_node = ItemFactoryManager.make_item()
			covering_items.append(new_node)
			new_node.add_child(new_node)
			new_node.init(covering, CarriedOrContained.On)

func set_image():
	pass

func put_item_into(game_item):
	pass

func put_item_onto(game_item):
	pass

func drop_item(game_item):
	pass
