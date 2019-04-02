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

	agent.sense = {}
	function agent.sense.r()
		for i = agent.x, maze.width, 1 do
			if trash_mesh.structure[i][agent.y] == 0 then
				return math.abs(i - agent.x)
			end
		end
		return 999
	end
	function agent.sense.l()
		for i = agent.x, maze.width, -1 do
			if trash_mesh.structure[i][agent.y] == 0 then
				return math.abs(i - agent.x)
			end
		end
		return 999
	end
	function agent.sense.u()
		for i = agent.y, maze.height, -1 do
			if trash_mesh.structure[agent.x][i] == 0 then
				return math.abs(i - agent.y)
			end
		end
		return 999
	end
	function agent.sense.d()
		for i = agent.y, maze.height, 1  do
			if trash_mesh.structure[agent.x][i] == 0 then
				return math.abs(i - agent.y)
			end
		end
		return 999
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
			-- collect
			if trash_mesh.structure[agent.x][agent.y] == 0 and agent.trash == 0 then
				trash_mesh.structure[agent.x][agent.y] = 1
				agent.trash = 1
			end
		elseif act == 3 then
			-- print("down")
			-- move down
			agent.y = agent.y + 1
			-- collect
			if trash_mesh.structure[agent.x][agent.y] == 0 and agent.trash == 0 then
				trash_mesh.structure[agent.x][agent.y] = 1
				agent.trash = 1
			end
		elseif act == 4 then
			-- print("up")
			-- move up
			agent.y = agent.y - 1
			-- collect
			if trash_mesh.structure[agent.x][agent.y] == 0 and agent.trash == 0 then
				trash_mesh.structure[agent.x][agent.y] = 1
				agent.trash = 1
			end
		end
	end

	function agent.ai()
		if agent.trash == 0 then
			local deltas = {}
  		deltas[1] = agent.sense.r()
  		deltas[2] = agent.sense.l()
  		deltas[3] = agent.sense.d()
  		deltas[4] = agent.sense.u()

  		-- init minimal value
  		local least = deltas[1]
  		local index = 1
  		for i = 2, 4 do
  			-- if there is someone bigger
  			if least > deltas[i] then
  				-- switch values
  				index = i
  				least = deltas[i]
  			end
  		end
  		
  		-- fazer varredura esquerda => direita
  		-- ou, direita => esquerda
  		if least == 999 then
  			-- if left conner, go right
  			if agent.x == 0 then
  				go_right = true
  				go_left = false

  			-- if right conner, go left
  			elseif agent.x == maze.width then
  				go_left = true
  				go_right = false
  			end
  			
  			-- go right
  			if go_right then
  				agent.take_action(1)

  			-- go left
  			elseif go_left then
  				agent.take_action(2)
  			end
  		else
  			agent.take_action(index)
  		end
  	else 
  		-- go to trash
  		if agent.x > 0 then
  			-- move left
  			agent.take_action(2)
  		elseif agent.y > 0 then
  			-- move up
  			agent.take_action(4)
  		else
  			--remove trash
  			agent.trash = 0
  		end
		end
	end


	return agent
end