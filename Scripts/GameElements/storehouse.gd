class_name Storehouse

extends Node2D

@export var key: String
@export var capacity: int
@export var current: int
@export var column: String
@export var color: Color
@export var is_full: bool 

var capacity_str := "(%s / %s)"
var name_str := "Depósito %s"

# Called when the node enters the scene tree for the first time.
func _ready():
	$label_capacity.text = capacity_str % [current , capacity]
	$label_capacity.modulate = color 
	$label_name_storehouse.text = name_str % [key]
	$label_name_storehouse.modulate = color 
	$ColorRect_store.color = color
	
func _process(delta):
	$label_capacity.text = capacity_str % [current , capacity]
	$label_capacity.modulate = color 
	$label_name_storehouse.text = name_str % [key]
	$label_name_storehouse.modulate = color 
	$ColorRect_store.color = color
