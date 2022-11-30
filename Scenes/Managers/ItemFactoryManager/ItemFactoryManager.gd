extends Node


@export
var game_item_node : PackedScene



func make_item() -> GameItemNode:
	return game_item_node.instantiate()
