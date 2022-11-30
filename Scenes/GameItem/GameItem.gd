extends Resource
class_name GameItem

enum GameItemType
{
	Location,
	Creature,
	Item,
	Writing
}


@export
var item_name := "A thing(No name)"
@export
var item_type : GameItemType
@export
var instance_name : String
@export
var log : bool
@export
var owner : String
@export
var maker : String
@export
var tags : Array[String]
@export
var values := {}
@export
var statuses := []
@export
var sub_items : Array[GameItem]
@export
var behavures := []
