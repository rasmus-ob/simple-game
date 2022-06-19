require 'src/Dependencies'

-- TODO Implement music and sound

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

	spawnTimer = 0

	points = 0

	nextLevel = 10

	pointsRemover = 1

	soundPowerup = love.audio.newSource("sound/powerup.wav", "static")
	soundExplosion1 = love.audio.newSource("sound/explosion.wav", "static")
	soundExplosion2 = love.audio.newSource("sound/explosion2.wav", "static")
	soundExplosion3 = love.audio.newSource("sound/explosion3.wav", "static")

	music = love.audio.newSource("sound/music.mp3", "static")

    music:setLooping(true)
    music:play()

    levelUpScreen = true


end

-- Setting up so resizing the screen works with push
function love.resize(w, h) 

	push:resize(w, h)

end

-- Getting input (storing it in 'love.keyboard.keysPressed' becuase we want to reach the keys pressed in other files)
function love.keypressed(key) 

	

	if state == 'start' then

		if key == 'return' then 

			state = 'play'

		end

	end

	if state == 'play' then 

		if key == 'r' then 

			state = 'start'
			player:reset()
			balls = {}
			points = 0

		end

	end

	if state == 'dead' then 

		if key == 'return' then 

			state = 'play'
			player:reset()
			balls = {}
			points = 0

		end

	end

	if state == 'win' then 

		if key == 'return' then 

			state = 'play'
			player:reset()
			balls = {}
			points = 0

		end

	end

	
end

function love.update(dt) 


	if state == 'play' then 

		player:update(dt)

		if points == nextLevel then 
			
			player:levelUp()

			nextLevel = nextLevel + 10
			pointsRemover = pointsRemover + 2

			levelUpScreen = true
			-- TODO Implement harder blocks

			soundPowerup:play()

		end

		if points == 50 then 

			state = 'win'

		end

		if points < 0 then
		 	player:reset()
			balls = {}
			state = 'dead'
			points = 0
		end

		for k, ball in pairs(balls) do 

			ball:update()

			if ball.y > VIRTUAL_HEIGHT + ball.height then

				table.remove(balls, k)

				points = points - pointsRemover

				math.randomseed(os.time())

				local random = math.random(1, 3)

				if random == 1 then 
					soundExplosion1:play()
				elseif random == 2 then
					soundExplosion2:play()

				else 
					soundExplosion3:play()
				end

			end

			

			if ball.y + ball.height - 2 >= player.y and ball.y + ball.height - 2 <= player.y + player.height and ball.x + ball.width >= player.x and ball.x <= player.x + player.width then

				points = points + 1

				table.remove(balls, k)

				math.randomseed(os.time())

				local random = math.random(1, 3)

				if random == 1 then 
					soundExplosion1:play()
				elseif random == 2 then
					soundExplosion2:play()

				else 
					soundExplosion3:play()
				end

			end


		end 


		spawnTimer = spawnTimer + dt

	    if spawnTimer >= 2 then
	        table.insert(balls, Ball())
	        spawnTimer = 0
	    end


	end

end

function love.draw() 

	push:start()

	love.graphics.clear(0, 0, 0)

	if levelUpScreen then 
		love.graphics.setColor(255, 255, 0)
		love.graphics.setFont(tutorialFont)
		love.graphics.printf("Level UP!", 0, VIRTUAL_HEIGHT - 48, VIRTUAL_WIDTH, "center")
		love.graphics.setColor(255, 255, 255)
	end


	if state == 'start' then
		player:render()
		love.graphics.setColor(255, 255, 255)
		love.graphics.setFont(titleFont)
		love.graphics.printf(GAME_TITLE, 0, 56, VIRTUAL_WIDTH, "center")

		if math.floor(love.timer.getTime()) % 2 == 0 then
    		love.graphics.setFont(tutorialFont)
			love.graphics.printf("Press Enter to begin", 0, 56+48, VIRTUAL_WIDTH, "center")
  		end
	end

	if state == 'play' then 

		player:render()

		for k, ball in pairs(balls) do 

			ball:render()

		end 

		love.graphics.setFont(tutorialFont)
		love.graphics.printf("Points: "..points, 0, 56+48, VIRTUAL_WIDTH, "center")

	end

	if state == 'dead' then 
		love.graphics.setColor(255, 0, 0)
		love.graphics.setFont(titleFont)
		love.graphics.printf("You Died!", 0, 56+32, VIRTUAL_WIDTH, "center")


		love.graphics.setFont(tutorialFont)
		love.graphics.printf("Press Enter to restart", 0, 56+48+32, VIRTUAL_WIDTH, "center")


		love.graphics.setColor(255, 255, 255)
		love.graphics.setFont(tutorialFont)
		love.graphics.printf("Points: " .. points, 0, 56+48+32+32, VIRTUAL_WIDTH, "center")

	end

	if state == 'win' then 
		love.graphics.setColor(255, 255, 0)
		love.graphics.setFont(titleFont)
		love.graphics.printf("Congratulations you won!", 0, 56+16, VIRTUAL_WIDTH, "center")


		love.graphics.setFont(tutorialFont)
		love.graphics.printf("Press Enter to restart", 0, 56+48+16, VIRTUAL_WIDTH, "center")


		love.graphics.setColor(255, 255, 255)
		love.graphics.setFont(tutorialFont)
		love.graphics.printf("Points: " .. points, 0, 56+48+32+16, VIRTUAL_WIDTH, "center")
		points = 0

	end

	push:finish()

end