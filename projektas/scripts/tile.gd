extends TileMap
var moisture = FastNoiseLite.new()
var temperature = FastNoiseLite.new()
var altitude = FastNoiseLite.new()
var trees = FastNoiseLite.new()
var width = 150
var height = 150
@onready var player = get_parent().get_child(1)
# Called when the node enters the scene tree for the first time.
func _ready():
	moisture.seed = randi()
	temperature.seed = randi()
	altitude.seed = randi()
#	trees.seed = randi()
	altitude.frequency = 0.001


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	generate_chunk(player.position)
	
func generate_chunk(position):
	var tile_pos = local_to_map(position)
	for x in range(width):
		for y in range(height):
			var moist = moisture.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)*10
			var temp = temperature.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)*10
			var alt = altitude.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)*10
			var tr = trees.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)*10
#			set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 0, Vector2i(round((moist+10)/5), round((temp+10)/5)))
#			set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 0, Vector2i(1, 1))
			if alt > 2:
				set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 0, Vector2i(3, round((temp+10)/5)))
			else:
				set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 0, Vector2i(round((moist+7)/5), round((temp+7)/5)))
				set_cell(1, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 1, Vector2i(round((moist+3)/5), round((temp+3)/5)))

