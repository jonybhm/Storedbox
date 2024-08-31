class_name Truck

extends Node2D

@export var current: int
@export var color_truck: Color

# Called when the node enters the scene tree for the first time.
func _ready():
	$label_boxes_in_truck.text = str(current)
	$label_boxes_in_truck.modulate = color_truck  

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$label_boxes_in_truck.text = str(current)
	$label_boxes_in_truck.modulate = color_truck
