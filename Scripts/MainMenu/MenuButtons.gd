extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$MainMenuBox/PlayButton.connect("pressed",Callable(self,"_on_PlayButton_pressed"))
	$MainMenuBox/OptionsButton.connect("pressed",Callable(self,"_on_OptionsButton_pressed"))
	$MainMenuBox/QuitButton.connect("pressed",Callable(self,"_on_QuitButton_pressed"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_PlayButton_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/levels_menu.tscn")


func _on_OptionsButton_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/options_menu.tscn")
	
	
func _on_QuitButton_pressed():
	get_tree().quit()

