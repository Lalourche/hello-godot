extends Node2D
class_name TimerTest, "res://icon.png"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal ready_signal(arg1, arg2)

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("ready_signal", 42, "test argument")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	$Sprite.visible = ! $Sprite.visible
