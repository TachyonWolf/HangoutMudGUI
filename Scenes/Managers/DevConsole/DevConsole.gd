extends CanvasLayer

signal line_entered(input_line)

@onready
var input : LineEdit = $Control/DevConsolePanel/InputLine
@onready
var output : RichTextLabel = $Control/DevConsolePanel/Panel/RichTextOutput

func _ready():
	output.append_text("\n")
#	for i in 200:
#		output.append_text("the quick brown fox jumped over the lazy dogs. " + str(i) + "\n")

func _process(delta):
	if(Input.is_action_just_pressed("toggle_dev_console") && !visible):
		visible = true
		input.grab_focus()
	elif(Input.is_action_just_pressed("toggle_dev_console")):
		visible = false

func _on_input_line_text_submitted(new_text):
	add_line(new_text, Color(0,1,0))
	if(new_text == "ping"):
		for player in MultiplayerManager.players_collection.get_children():
			log_info("Ping:" + str(player.ping) + "Player: " + player.user_name)

func add_line(new_line, color : Color):
	add_text(str(new_line) + "\n", color)

func add_text(new_text, color : Color):
	output.append_text("[color=#" + color.to_html() + "]" + new_text + "[/color]")


func log_info(new_line):
	add_line("\t" + new_line, Color("ffffff"))

func log_network(new_line):
	add_line("\t\t\t" + new_line, Color("008eff"))

func log_temp(new_line):
	add_line(new_line, Color("b800ff"))

func log_error(new_line):
	add_line(new_line, Color(1,0,0))

func move_test_dot(point):
	$TestDot.visible = true
	$TestDot.position = point
