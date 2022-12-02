extends Control
class_name WorldView

@export
var ItemTree : Tree

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func build_full_tree(game_node : GameItemNode):
	ItemTree.clear()
	admin_node_build(game_node, null)

func admin_node_build(game_node : GameItemNode, parent_node):
	var new_tree_item := ItemTree.create_item(parent_node)
	if(!game_node.game_item):
		return
	
	if(game_node.game_item.instance_name):
		new_tree_item.set_text(0, game_node.game_item.instance_name)
	else:
		new_tree_item.set_text(0, game_node.game_item.item_name)
	new_tree_item.set_custom_color(0, get_color(game_node))
	
	for items in game_node.sub_items:
		admin_node_build(items, new_tree_item)

func get_color(game_node: GameItemNode) -> Color:
	if(game_node == MultiplayerManager.controlled_item):
		return Color.LIGHT_SKY_BLUE
	if(game_node.game_item.item_type == GameItem.GameItemType.Location):
		return Color.GREEN
	elif(game_node.game_item.item_type == GameItem.GameItemType.Creature):
		return Color.BLUE
	return Color.WHITE
