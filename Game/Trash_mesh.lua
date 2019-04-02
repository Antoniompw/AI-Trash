function Trash_mesh(maze)
	local trash_mesh = {}
	trash_mesh.maze = maze

	-- model image
	trash_mesh.image = love.graphics.newImage("trash.png")
	
	-- how much the image needs to be scaled down to fit the tile
	local how_much_is_needed_x = 0.04
	local how_much_is_needed_y = 0.04
	local image_w
	local image_h
	image_w, image_h = trash_mesh.image:getDimensions()
	local window_w = love.graphics.getWidth()
	local window_h = love.graphics.getHeight()
	local how_much_w = image_w/window_w
	local how_much_h = image_h/window_h
	-- desired scale
	local scale_w = how_much_is_needed_x * (1/how_much_w)
	local scale_h = how_much_is_needed_y * (1/how_much_h)
	-- pixels ocuppied by the rendered image 
	local real_w = image_w*scale_w
	local real_h = image_h*scale_h
	print(scale_w, scale_h)



	-- This function means to redraw all trash positions
	function trash_mesh.design()
		-- Distributes random numbers through mesh
		trash_mesh.structure = {}
		for i = 0, maze.height do
			trash_mesh.structure[i] = {}
			for j = 0, maze.width do
				trash_mesh.structure[i][j] = math.random(0, 1)
			end
		end
	end
	-- this function renders all the trashs
	function trash_mesh.draw()
		love.graphics.setColor(255, 255, 255)
		local x
		local y
		-- proportion between tilesize and trash
		local scale = 0.2
		for i = 0, trash_mesh.maze.height do
			for j = 0, trash_mesh.maze.width do
				-- to make it center it's own tile
				x = i * maze.tile_w + maze.tile_w/2 - real_w/2
				y = j * maze.tile_h + maze.tile_h/2 - real_h/2
				-- draw trashs
				if trash_mesh.structure[i][j] == 0 then
					love.graphics.draw(trash_mesh.image, x, y, 0, scale_w, scale_h)
				end
			end
		end
	end
	return trash_mesh
end