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

	balls = {}

	titleFont = love.graphics.newFont('fonts/edunline.ttf', 32)
	tutorialFont = love.graphics.newFont('fonts/edunline.ttf', 16)

	state = 'start'

	timer = 0

	points = 0
end

-- Setting up so resizing the screen works with push
function love.resize(w, h) 

	push:resize(w, h)

end

-- Getting input (storing it in 'love.keyboard.keysPressed' becuase we want to reach the keys pressed in other files)
function love.keypressed(key) 

	

	if(state == 'start') then

		if(key == 'return') then 

			state = 'play'

		end

	end

	if state == 'play' then 

		if(key == 'r') then 

			state = 'start'
			player:reset()

		end

	end

	
end

nextLevel = 10
function love.update(dt) 

	player:update(dt)


	if state == 'play' then 

		if points == nextLevel then 
			
			player:levelUp()

			nextLevel = nextLevel + 10

			-- TODO Implement levelUp Screen
			-- TODO Implement harder blocks

		end

		if points == 100 then 

			state = 'win'

			-- TODO Implement win state

		end

		for k, ball in pairs(balls) do 

			ball:update()

			if ball.y > VIRTUAL_HEIGHT + 100 then

				table.remove(balls, k)

				points = points - 5

			end

			if(points < 0) then 

				state = 'death'

				-- TODO Implement death state

			end

			if ball.y + ball.height - 2 >= player.y and ball.y + ball.height - 2 <= player.y + player.height and ball.x + ball.width >= player.x and ball.x <= player.x + player.width then

				points = points + 1

				table.remove(balls, k)

			end


		end 


		timer = timer + dt

	    if timer >= 2 then
	        table.insert(balls, Ball())
	        timer = 0
	    end


	end

end

function love.draw() 

	push:start()

	love.graphics.clear(0, 0, 0)

	player:render()


	if(state == 'start') then
		love.graphics.setColor(255, 255, 255)
		love.graphics.setFont(titleFont)
		love.graphics.printf(GAME_TITLE, 0, 56, VIRTUAL_WIDTH, "center")

		if math.floor(love.timer.getTime()) % 2 == 0 then
    		love.graphics.setFont(tutorialFont)
			love.graphics.printf("Press Enter to begin", 0, 56+48, VIRTUAL_WIDTH, "center")
  		end
	end

	if state == 'play' then 

		for k, ball in pairs(balls) do 

			ball:render()

		end 

		love.graphics.setFont(tutorialFont)
		love.graphics.printf("Points: "..points, 0, 56+48, VIRTUAL_WIDTH, "center")

	end

	push:finish()

end