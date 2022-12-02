extends Control
class_name WorldView

@export
var BaseItemTree : Tree
var tree_to_game_nodes : Dictionary
var game_to_tree_nodes : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	tree_to_game_nodes = {}
	game_to_tree_nodes = {}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func build_full_tree(game_node : GameItemNode):
	BaseItemTree.clear()
	tree_to_game_nodes.clear()
	game_to_tree_nodes.clear()
	admin_node_build(game_node, null)

func admin_node_build(game_node : GameItemNode, parent_node):
	var new_tree_item = add_node(game_node, parent_node)
	
	if(!game_node.game_item):
		return
	
	
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

func add_node(game_node : GameItemNode, parent_node : TreeItem) -> TreeItem:
	var new_tree_item := BaseItemTree.create_item(parent_node)
	game_to_tree_nodes[game_node] = new_tree_item
	tree_to_game_nodes[new_tree_item] = game_node
	game_node.child_exiting_tree.connect(child_node_removed)
	game_node.child_entered_tree.connect(child_node_removed)
#	game_node.data_updated.connect()
	update_visibility(game_node, new_tree_item)
	return new_tree_item

func remove_node(game_node : GameItemNode):
	var tree_node = tree_to_game_nodes[game_node]
	game_to_tree_nodes.erase(game_node)
	tree_to_game_nodes.erase(tree_node)
	for child in game_node.get_children():
		remove_node(child)
	game_node.child_exiting_tree.disconnect(child_node_removed)
	game_node.child_entered_tree.disconnect(child_node_removed)
	#	game_node.data_updated.disconnect()

func child_node_removed(game_node):
	remove_node(game_node)

func child_node_added(game_node):
	pass


func update_visibility(game_node : GameItemNode, tree_item : TreeItem):
	if(game_node.game_item.instance_name):
		tree_item.set_text(0, game_node.game_item.instance_name)
#		new_tree_item.visible = false
	else:
		tree_item.set_text(0, game_node.game_item.item_name)
	tree_item.set_custom_color(0, get_color(game_node))


func _on_item_tree_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			var items := []
			var item = BaseItemTree.get_selected()
			while(item):
				var game_node = tree_to_game_nodes[item]
				items.append(game_node.uid)
				item = BaseItemTree.get_next_selected(item)
			print(items)
