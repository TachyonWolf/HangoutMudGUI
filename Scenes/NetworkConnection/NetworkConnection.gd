extends Control

@export
var GameScene : PackedScene

func _on_host_button_pressed():
	MultiplayerManager.user_name = $VBoxContainer/NameHBox/PlayerLabel.get_text()
	var port_text = $VBoxContainer/PortHBox/PortSettingBox.get_text()
	MultiplayerManager.start_server(port_text.to_int())
	_load_into_gamescene()

func _on_join_button_pressed():
	MultiplayerManager.user_name = $VBoxContainer/NameHBox/PlayerNameBox.get_text()
	var ip = $VBoxContainer/IpHBox/IpSettingBox.get_text()
	var port_text = $VBoxContainer/PortHBox/PortSettingBox.get_text()
	MultiplayerManager.join_server(ip, port_text.to_int())
	_load_into_gamescene()

func _load_into_gamescene():
	get_tree().change_scene_to_packed(GameScene)
