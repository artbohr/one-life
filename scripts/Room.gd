extends Node2D


export (PackedScene) var lily
export (PackedScene) var letter

signal kill

var showing_letter = false

var available = [1,2,3,4,5,6,7]
var selected = 1


func _ready():
	for x in range(1,8):
		spawn_lily(x*155)
		$Timer.start()

func _process(delta):
	if available.size() == 1 and selected == 2:
		get_tree().change_scene('res://scenes/GameCompleted.tscn')
	
	check_timer()
	change_selected()
	show_text()
	manage_letter()
	kill()

func spawn_lily(x_pos):
	var new_lily = lily.instance()
	new_lily.id = x_pos/155
	new_lily.position = Vector2(x_pos, 360)
	#get_node("Stand").
	add_child(new_lily)
	
func check_timer():
	if $Timer.time_left < 0.05:
		get_tree().change_scene('res://scenes/GameOver.tscn')

	else:
		get_node("Control/Timer_text").text = str(int($Timer.time_left))
		
func change_selected():
	if Input.is_action_just_pressed('ui_left'):
		#$Select.play()
		if selected > available[0]:
			selected = available[available.find(selected) - 1]
		else:
			selected = available[-1]
	elif Input.is_action_just_pressed('ui_right'):
		#$Select.play()
		if selected < available[-1]:
			selected = available[available.find(selected) + 1]
		else:
			selected = available[0]
			
func kill():
		
	if Input.is_action_just_pressed('kill'):
		if selected == 2:
			get_tree().change_scene('res://scenes/GameOver.tscn')
		if available.size() > 1:
			available.erase(selected)
		
		$Kill.play()
		$Timer.start()
		emit_signal('kill')
		selected = available[0]

		
func show_text():
	$TextBox.text = 'Lily ' + str(selected) + ' : ' + PHRASES.data[selected]
	
func manage_letter():
	if Input.is_action_just_pressed('show_letter') and !showing_letter:
		showing_letter = true
		var new_letter = letter.instance()
		new_letter.position = Vector2(640, 360)
		add_child(new_letter)
	elif Input.is_action_just_pressed('show_letter') and showing_letter:
		if self.get_children()[-1].get_name() == 'Letter':
			get_children()[-1].queue_free()
			showing_letter = false