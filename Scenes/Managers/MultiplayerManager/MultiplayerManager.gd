extends Node


signal player_joined(id : int)
signal player_left(id : int)

var _peer
var user_name := "Bob" + str(get_instance_id())
var controlled_item : GameItem

func start_server(port : int):
	_peer = ENetMultiplayerPeer.new()
	var error = _peer.create_server(port)
	multiplayer.set_multiplayer_peer(_peer)
	DevConsole.log_network("server listening on port:" + str(port))

func join_server(ip : String, port : int) -> bool:
	_peer = ENetMultiplayerPeer.new()
	DevConsole.log_network("Joining to server at: " + ip + ":" + str(port))
	var error = _peer.create_client(ip, port)
	if(error == OK):
		DevConsole.log_network("Joined with error code:" + str(error))
	else:
		return false
	multiplayer.set_multiplayer_peer(_peer)
	DevConsole.log_network("Joined as player: " + str(multiplayer.get_unique_id()))
	return true
