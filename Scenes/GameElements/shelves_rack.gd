class_name ShelvesRack

extends Node2D

@export var value_per_box: int 
@export var color_value: Color
@export var current: int 
@export var color_cuantity: Color
@export var row: String
@export var column: String
@export var is_full: bool 
@export var key:String


var column_row_str := "[%s %s]"
var value_str := "$%s X caja"

signal boxes_added(row,column)
# Called when the node enters the scene tree for the first time.
func _ready():
	$column_row.text = column_row_str % [column,row]
	$label_value_per_box.text = value_str % [value_per_box]
	$label_value_per_box.modulate = color_value
	$label_boxes_cuantity.text = str(current)
	$label_boxes_cuantity.modulate = color_cuantity
	#señales
	$Area2D/ShelvesButton.connect("pressed",Callable(self,"_on_ShelvesButton_pressed"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$column_row.text = column_row_str % [column,row]
	$label_value_per_box.text = value_str % [value_per_box]
	$label_value_per_box.modulate = color_value
	$label_boxes_cuantity.text = str(current)
	$label_boxes_cuantity.modulate = color_cuantity
	
func _on_ShelvesButton_pressed():
	add_boxes()
	
func add_boxes():
	emit_signal("boxes_added",self.row,self.column)
	



