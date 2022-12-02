extends Resource
class_name GameItem

enum GameItemType
{
	Location,
	Creature,
	Item,
	Writing
}

enum ParentRelationship
{
	Inside,
	On,
	Outmost,
	Held
}

@export
var item_name := "A thing - No name"
@export
var item_type : GameItemType
@export
var instance_name : String
@export
var sprite_path : String
@export
var description : String

var uid : int

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
var parent_relationship : ParentRelationship
@export
var location : String
@export
var behavures := []


