require 'src/Dependencies'

function love.load() 

	love.window.setTitle(GAME_TITLE)

	love.graphics.setDefaultFilter('nearest', 'nearest')

	-- Setting up push ( resolution-handling library )
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true,
		fullscreen = false,
		resizable = true
	})

	player = Player()

	titleFont = love.graphics.newFont('fonts/edunline.ttf', 32)
	tutorialFont = love.graphics.newFont('fonts/edunline.ttf', 16)

	state = 'start'

end

-- Setting up so resizing the screen works with push
function love.resize(w, h) 

	push:resize(w, h)

end

-- Getting input (storing it in 'love.keyboard.keysPressed' becuase we want to reach the keys pressed in other files)
function love.keypressed(key) 

	if(key == 'escape') then 

		state = 'pause'

	end

	if(key == 'enter') then 

		state = 'play'

	end

	
end

function love.update(dt) 

	player:update(dt)

end

function love.draw() 

	push:start()

	love.graphics.clear(255, 255, 0)

	player:render()


	if(state == 'start') then
		love.graphics.setColor(255,0,255)
		love.graphics.setFont(titleFont)
		love.graphics.printf(GAME_TITLE, 0, 56, VIRTUAL_WIDTH, "center")

		if math.floor(love.timer.getTime()) % 2 == 0 then
    		love.graphics.setFont(tutorialFont)
			love.graphics.printf("Press Enter to begin", 0, 56+48, VIRTUAL_WIDTH, "center")
  		end
	end

	if(state == 'pause') then 

		-- Implement pause state

	end

	if state == 'play' then 

		-- implement new play state

	end

	push:finish()

end