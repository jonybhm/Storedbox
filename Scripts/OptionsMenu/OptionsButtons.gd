extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$OptionsMenuBox/BackButton.connect("pressed",Callable(self,"_on_BackButton_pressed"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")