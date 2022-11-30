extends Node


@export
var game_item_node : PackedScene



func make_item() -> GameItemNode:
	var node = game_item_node.instantiate()
	return node
