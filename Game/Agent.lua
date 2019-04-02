-- Agent exemple. AI
function Agent(x, y, image, maze, trash_mesh)
	local agent = {}
	-- model position inside maze
	agent.x = x
	agent.y = y
	-- model sizes
	agent.w = 10
	agent.h = 10
	-- model image path
	agent.image = image
	agent.trash = 0
	agent.steps = 0
	-- copies reference
	agent.tm = trash_mesh
	function agent.draw()
		-- calculations needed to align agent to center
		local r = 0
		local g = 0
		local b = 0
		love.graphics.setColor(r, g, b)
		local x = agent.x * maze.tile_w + maze.tile_w/2 - agent.h/2
		local y = agent.y * maze.tile_h + maze.tile_h/2 - agent.w/2
		love.graphics.rectangle("fill", x, y, agent.w, agent.h)
	end

  	function agent.senses()
  		local x, y
  		x = {}
  		y = {}
  		
  		for i = 0, table.getn(trash_mesh) do
  			x[i] = trash_mesh.structure[i][agent.y]
  			y[i] = trash_mesh.structure[agent.x][i]
  		end
  		return x, y
  	end

  	function agent.take_action(act)
  		if act == 1 then
  			-- print("right")
  			-- move right
  			agent.x = agent.x + 1
  			if trash_mesh.structure[agent.x][agent.y] == 0 and agent.trash == 0 then
  				trash_mesh.structure[agent.x][agent.y] = 1
  				agent.trash = 1
  			end
  		elseif act == 2 then
  			-- print("left")
  			-- move left
  			agent.x = agent.x - 1
  			if trash_mesh.structure[agent.x][agent.y] == 0 and agent.trash == 0 then
  				trash_mesh.structure[agent.x][agent.y] = 1
  				agent.trash = 1
  			end
  		elseif act == 3 then
  			-- print("down")
  			-- move down
  			agent.y = agent.y + 1
  			if trash_mesh.structure[agent.x][agent.y] == 0 and agent.trash == 0 then
  				trash_mesh.structure[agent.x][agent.y] = 1
  				agent.trash = 1
  			end
  		elseif act == 4 then
  			-- print("up")
  			-- move up
  			agent.y = agent.y - 1
  			if trash_mesh.structure[agent.x][agent.y] == 0 and agent.trash == 0 then
  				trash_mesh.structure[agent.x][agent.y] = 1
  				agent.trash = 1
  			end
  		end
  	end

  	function agent.ai()
  		if agent.trash == 0 then
	  		local x
	  		local y
	  		x, y = agent.senses()
	  		minx = 999
	  		miny = 999
	  		for i = 0, table.getn(x) do
	  			if x[i] == 1 then
	  				if math.abs(agent.x - i) < math.abs(agent.x - minx) then
	  					minx = i
	  				end
	  			end
	  		end
	  		for i = 0, table.getn(y) do
	  			if y[i] == 1 then
	  				if math.abs(agent.y - i) < math.abs(agent.y - miny) then
	  					miny = i
	  				end
	  			end
	  		end
	  		
	  		-- if there aint any near
	  		if minx == 999 and miny == 999 then
	  			agent.take_action(math.random(1, 4))
	  		end
	  		print(minx, miny)
	  		-- which axis has the nearest point?
	  		if math.abs(agent.x - minx) < math.abs(agent.y - miny) then
	  			-- if the minimal distance x axis is greater, go right
	  			if minx > agent.x then
	  				agent.take_action(1)
	  			
	  			-- else, go left
	  			else 
	  				agent.take_action(2)
	  			end
	  		else
	  			-- if the minimal distance y axis is greater, go down
	  			if miny > agent.y then
	  				agent.take_action(3)

	  			-- else, go up
	  			else
	  				agent.take_action(4)
	  			end
	  		end
	  	else 
	  		-- go to trash
	  		if agent.x > 0 then
	  			-- move left
	  			agent.take_action(2)
	  		elseif agent.y > 0 then
	  			-- move up
	  			agent.take_action(3)
	  		else
	  			--remove trash
	  			agent.trash = 0
	  		end

  		end
  	end


	return agent
end