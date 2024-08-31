extends Node2D



#CAPACIDAD DE LOS DEPOSITOS
var dict_storehouses_values := {
	"storehouse_1":{
		"name_storage_1" : "1",
		"color_storehouse_1" : Color(Color.MEDIUM_AQUAMARINE),
		"capacity_storage_1" : 30,
		"current_storage_1" : 0
	},
	"storehouse_2":{
		"name_storage_2" : "2",
		"color_storehouse_2" : Color(Color.LIGHT_PINK),
		"capacity_storage_2" : 110,
		"current_storage_2" : 0,
	},
	"storehouse_3":{
		"name_storage_3" : "3",
		"color_storehouse_3" : Color(Color.POWDER_BLUE),
		"capacity_storage_3" : 80,
		"current_storage_3" : 0,
	}
}


#PRODUCCION DE LAS FABRiCAS
var dict_factories_values := {
	"factory_A":{
		"name_factory_A" : "A",
		"color_factory_A" : Color(Color.CRIMSON),
		"production_factory_A" : 130,
		"current_factory_A" : 130,
		"current_truck_A" : 0
	},
	"factory_B":{
		"name_factory_B" : "B",
		"color_factory_B" : Color(Color.DARK_SLATE_BLUE),
		"production_factory_B" : 90,
		"current_factory_B" : 90,
		"current_truck_B" : 0
	}
}


#CAPACIDAD DE LAS ESTANTERIAS
var dict_shelves_values :={
	"shelve_1A":{
		"current_shelves_1A" : 0,
		"value_shelves_1A" : 2
	},
	"shelve_2A":{
		"current_shelves_2A" : 0,
		"value_shelves_2A" : 5
	},
	"shelve_3A":{
		"current_shelves_3A" : 0,
		"value_shelves_3A" : 7
	},
	"shelve_1B":{
		"current_shelves_1B" : 0,
		"value_shelves_1B" : 3
	},
	"shelve_2B":{
		"current_shelves_2B" : 0,
		"value_shelves_2B" : 2
	},
	"shelve_3B":{
		"current_shelves_3B" : 0,
		"value_shelves_3B" : 8
	}
}



#INSTANCIAS CLASES
@export var factory_A := Factory.new()
@export var factory_B := Factory.new()
@export var truck_A := Truck.new()
@export var truck_B := Truck.new()

@export var storehouse_1 := Storehouse.new()
@export var storehouse_2 := Storehouse.new()
@export var storehouse_3 := Storehouse.new()

@export var shelves_1A := ShelvesRack.new()
@export var shelves_2A := ShelvesRack.new()
@export var shelves_3A := ShelvesRack.new()
@export var shelves_1B := ShelvesRack.new()
@export var shelves_2B := ShelvesRack.new()
@export var shelves_3B := ShelvesRack.new()

#MATRIZ PRINCIPAL

var shelves := {}
var factories := {}
var storehouses := {}
var rows := ["A","B"]
var columns := [1,2,3]

# Called when the node enters the scene tree for the first time.
func _ready():
	$UI/TutorialButtons/PlayButton.connect("pressed",Callable(self,"_on_PlayButton_pressed"))
	
	#AGREGAR VALORES A LAS ESTANTERIAS
	for row in rows:
		for col in columns:
			var shelve_name = "shelves_"+str(col)+row
			var shelve = get(shelve_name)
			#shelves.append(shelve)
			shelve.row = str(row)
			shelve.column = str(col)
			shelve.key = shelve.column + shelve.row
			shelves[shelve.column + shelve.row]=shelve #agregar al diccionario
			
			shelve.current = dict_shelves_values["shelve_"+str(col)+row]["current_shelves_"+str(col)+row]
			shelve.color_cuantity = dict_storehouses_values["storehouse_"+str(col)]["color_storehouse_"+str(col)]
			shelve.value_per_box = dict_shelves_values["shelve_"+str(col)+row]["value_shelves_"+str(col)+row]
			shelve.color_value = dict_factories_values["factory_"+row]["color_factory_"+row]
			shelve.is_full = false
			#CONECTAR SEÑALES
			shelve.connect("boxes_added",Callable(self,"_on_boxes_added"))
	
	#AGREGAR VALORES A LAS FABRICAS Y CAMIONES
	for row in rows:
		var factory_name = "factory_"+row
		var factory = get(factory_name)
		var truck = get("truck_"+row)
		factory.row = str(row)
		factories[factory.row]=factory#agregar al diccionario
		
		factory.key = dict_factories_values["factory_"+row]["name_factory_"+row]
		factory.production = dict_factories_values["factory_"+row]["production_factory_"+row]
		factory.current = dict_factories_values["factory_"+row]["current_factory_"+row]
		factory.color = dict_factories_values["factory_"+row]["color_factory_"+row]
		factory.is_empty = false
		
		truck.color_truck = dict_factories_values["factory_"+row]["color_factory_"+row]
		truck.current = dict_factories_values["factory_"+row]["current_truck_"+row]
	
	#AGREGAR VALORES A LOS DEPOSITOS
	for col in columns:
			var storehouse_name = "storehouse_"+str(col)
			var storehouse = get(storehouse_name)
			storehouse.column = str(col)
			storehouses[storehouse.column]=storehouse#agregar al diccionario
			
			storehouse.key = dict_storehouses_values["storehouse_"+str(col)]["name_storage_"+str(col)]
			storehouse.capacity = dict_storehouses_values["storehouse_"+str(col)]["capacity_storage_"+str(col)]
			storehouse.current = dict_storehouses_values["storehouse_"+str(col)]["current_storage_"+str(col)]
			storehouse.color = dict_storehouses_values["storehouse_"+str(col)]["color_storehouse_"+str(col)]
			storehouse.is_full = false
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#==========================AL PRESIONAR PLAY==========================
func _on_PlayButton_pressed():
	print("SE TOCO PLAY")
	var max_stops := 4
	var truck_stops := 0
	for shelve in shelves:
		if shelves[shelve].current != 0:
			truck_stops += 1
	if truck_stops > max_stops:
		print("SUPERA EL MAXIMO DE PARADAS")
	else:
		print("costo total = " + str(calculate_total_cost(shelves)))
		show_values(shelves)
		

func calculate_total_cost(shelves):
	var total_cost := 0
	for shelve in shelves:
		total_cost += shelves[shelve].current * shelves[shelve].value_per_box
		print(str(total_cost))
	return total_cost

func show_values(shelves):
	for shelve in shelves:
			print("=======================================")
			print("\nNombre: "+ shelves[shelve].key)
			print("\nCantidad: "+ str(shelves[shelve].current))
			print("\nCosto por caja: "+ str(shelves[shelve].value_per_box))


	#==========================MOVIMIENTO DE CAJAS==========================
func _on_boxes_added(row,column):
	var quantity := 10
	var storehouse = storehouses[column]
	var shelve = shelves[column+row]
	var factory = factories[row]
	
	#-----------------------VERIFICAR QUE SE PUEDAN MOVER LAS CAJAS-----------------------
	if factory.current >= quantity && !shelve.is_full && !storehouse.is_full:
		
		#-----------------------QUITAR CAJAS DE LA FABRICA-----------------------
		factory.current = substract_boxes_from_factory(factory.current,quantity)
		if factory.current == 0:
			factory.is_empty = true
		print("CAJA EXTRAIDA DE FABRICA " +factory.key)
		
		#-----------------------AGREGAR CAJAS AL DEPOSITO-----------------------
		storehouse.current = add_boxes_to_storage(storehouse.current,storehouse.capacity,quantity)
		if storehouse.current == storehouse.capacity:
			storehouse.is_full = true
		print("CAJA AGREGADA A DEPOSITO " +storehouse.key)
		
		#-----------------------AGREGAR CAJAS A LA ESTANTERIA-----------------------
		shelve.current = add_boxes_to_shelve(shelve.current, rows, storehouse.capacity, column, quantity)
		if calculate_total_boxes_in_storehouse(column, rows) >= storehouse.capacity:
			shelve.is_full = true
		#print("total actual="+str(calculate_total_boxes_in_storehouse(column, rows))+"capadidad="+str(storehouse.capacity))
		print("CAJA AGREGADA A REPISA "+shelve.key)
	
	
func calculate_total_boxes_in_storehouse(column,rows):
	var total : int = 0
	for row in rows:
		total += shelves[column+row].current
	return total

func add_boxes_to_shelve(current,rows,capacity,column, quantity):
	var total = calculate_total_boxes_in_storehouse(column,rows)
	if total + quantity <= capacity:
		current += quantity
	elif total == capacity:
		print("capacidad de deposito completa!!")
	return current

func add_boxes_to_storage(current,capacity,quantity):
	if current + 10 <= capacity:
		current += 10
	elif current == capacity:
		print("capacidad de deposito completa!!")
	return current

func substract_boxes_from_factory(current, quantity):
	if current >= quantity:
		current -= quantity
	elif current == 0:
		print("fabrica vacia!!")
	return current
	
	#TODO ==========================CARGAR INFORMACION DE NIVELES DESDE UN JSON========================== 
	#func load_json(path: String):
	#var file := File.new()
	#file.open(path, File.READ)
	#var content = file.get_as_text()
	#file.close()
	#var parsed_json: JSONParseResult = JSON.parse(content)
	#if not parsed_json.error:
		#return parsed_json.result
