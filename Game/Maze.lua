-- This function means to render the maze where the algorithm is aplied
function Maze()
	local maze
	local window_height = love.graphics.getHeight()
	local window_width = love.graphics.getWidth()  
	maze = {}
  maze.height = 20
  maze.width = 20
 	maze.structure = {}
  for i = 0, maze.height do
  	maze.structure[i] = {}
  	for j = 0, maze.width do
  		maze.structure[i][j] = 0
  	end
  end
  maze.tile_h = window_height/maze.height
  maze.tile_w = window_width/maze.width
	function maze.draw()
		local x 
		local y 
		local w = maze.tile_w
		local h = maze.tile_h
		local r = 200
		local g = 200
		local b = 200
		for i, column in ipairs(maze.structure) do
			for j, item in ipairs(column) do
				if item == 0 then
					x = (i-1)*maze.tile_w
					y = (j-1)*maze.tile_h
					w = maze.tile_w
					h = maze.tile_h
					r = 200
					g = 200
					b = 200
					love.graphics.setColor(r, g, b)
					love.graphics.rectangle("fill", x, y, w, h)
					r = 200
					b = 0
					g = 0
					love.graphics.setColor(r, g, b)
					love.graphics.rectangle("line", x, y, w, h)
				end
			end
		end
	end
	return maze
end
