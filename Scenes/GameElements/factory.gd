class_name Factory

extends Node2D

@export var key: String
@export var row: String
@export var production: int
@export var current: int
@export var color: Color
@export var is_empty: bool 


var production_str := "(%s / %s)"
var name_str := "Fábrica %s"
# Called when the node enters the scene tree for the first time.
func _ready():
	$label_production.text = production_str % [current , production]
	$label_production.modulate = color 
	$label_factory_name.text = name_str % [key]
	$label_factory_name.modulate = color 
	$ColorRect_route.color = color
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$label_production.text = production_str % [current , production]
	$label_production.modulate = color 
	$label_factory_name.text = name_str % [key]
	$label_factory_name.modulate = color 
	$ColorRect_route.color = color
