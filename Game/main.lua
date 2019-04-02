-- This file means to serve as an practical example for IA classes
-- Load love2d variables
require 'Trash_mesh'
require 'Maze'
require 'Agent'
function love.load()
	love.window.setTitle("AI aplications")
	maze = Maze()
	trash_mesh = Trash_mesh(maze)
	trash_mesh.design()
	agent = Agent(0, 1, "player.png", maze, trash_mesh)
  desktop_height, desktop_width = love.window.getDesktopDimensions()
  window_height = love.graphics.getHeight()
  window_width = love.graphics.getWidth()
  
end

-- Function that refreshes the system
function love.update(dt)
  agent.ai()
end

-- Function that controls all rendering
function love.draw()
	maze.draw()
	trash_mesh.draw()
	agent.draw()
end

function love.keypressed(key, scancode, isrepeat)
	-- control scheme
  if(key == "q") then
  	print("End")
    love.window.close()
  -- This is the manual control
  --[[
  elseif(key == "down" and agent.y < maze.height) then
  	agent.y = agent.y + 1
  	if trash_mesh.structure[agent.x][agent.y] == 0 then
  		agent.score = agent.score + 1
  	end
  	agent.steps = agent.steps + 1
  	print("Score:"..agent.score, "Steps:"..agent.steps)
  	trash_mesh.structure[agent.x][agent.y] = 1
  elseif(key == "up" and agent.y > 0) then
  	agent.y = agent.y - 1
  	if trash_mesh.structure[agent.x][agent.y] == 0 then
  		agent.score = agent.score + 1
  	end
  	agent.steps = agent.steps + 1
  	print("Score:"..agent.score, "Steps:"..agent.steps)
  	trash_mesh.structure[agent.x][agent.y] = 1
  elseif(key == "right" and agent.x < maze.width) then
  	agent.x = agent.x + 1
  	if trash_mesh.structure[agent.x][agent.y] == 0 then
  		agent.score = agent.score + 1
  	end
  	agent.steps = agent.steps + 1
  	print("Score:"..agent.score, "Steps:"..agent.steps)
  	trash_mesh.structure[agent.x][agent.y] = 1
  elseif(key == "left" and agent.x > 0) then
  	agent.x = agent.x - 1
  	if trash_mesh.structure[agent.x][agent.y] == 0 then
  		agent.score = agent.score + 1
  	end
  	agent.steps = agent.steps + 1
  	print("Score:"..agent.score, "Steps:"..agent.steps)
  	trash_mesh.structure[agent.x][agent.y] = 1
  ]]--
  end
end
