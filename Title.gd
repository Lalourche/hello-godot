extends Panel


# Declare member variables here. Examples:
var gameScene
var gameNode: Node


# Called when the node enters the scene tree for the first time.
func _ready():
	gameScene = preload("res://HelloWalls.tscn")
	var _err = get_node("Button").connect("pressed", self, "_on_Button_pressed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var count = float(get_node("Counter").text)
	get_node("Counter").text = str(count + delta)


func _on_Button_pressed():
	# Delete previous game if present
	if gameNode != null && gameNode.is_inside_tree():
		gameNode.queue_free()
	# Instanciate game scene
	gameNode = gameScene.instance()
	add_child(gameNode)
