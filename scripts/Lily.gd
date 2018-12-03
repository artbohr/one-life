extends Node2D

var id = 100
onready var room = get_node("/root/Room")

func _ready():
	room.connect("kill", self, "liquidate")

func _process(delta):
	show_attr()

func liquidate():
	if id == room.selected:
		self.queue_free()
		
func show_attr():
	if id == room.selected:
		$ArrowLeft.show()
		$ArrowRight.show()
		$SpeechBubble.show()
	else:
		$ArrowLeft.hide()
		$ArrowRight.hide()
		$SpeechBubble.hide()