extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$LevelsMenuBox/TutorialButton.connect("pressed",Callable(self,"_on_TutorialButton_pressed"))
	$LevelsMenuBox/BackButton.connect("pressed",Callable(self,"_on_BackButton_pressed"))
	$LevelsMenuBox/Level1Button.connect("pressed",Callable(self,"_on_Level1Button_pressed"))
	$LevelsMenuBox/Level2Button.connect("pressed",Callable(self,"_on_Level2Button_pressed"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_TutorialButton_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/tutorial.tscn")
	
func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")

func _on_Level1Button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
	
func _on_Level2Button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_2.tscn")
