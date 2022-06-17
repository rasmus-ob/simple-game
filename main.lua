require 'src/Dependencies'

function love.load() 

	love.graphics.setDefaultFilter('nearest', 'nearest')

	-- Setting up push ( resolution-handling library )
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true,
		fullscreen = false,
		resizable = true
	})

	love.keyboard.keysPressed = {}

	player = Player()

end

-- Setting up so resizing the screen works with push
function love.resize(w, h) 

	push:resize(w, h)

end

-- Getting input (storing it in 'love.keyboard.keysPressed' becuase we want to reach the keys pressed in other files)
function love.keypressed(key) 

	if(key == 'escape') then 

		love.event.quit()

	end

	
end

function love.update(dt) 

	player:update(dt)



end

function love.draw() 

	push:start()

	love.graphics.printf("Hello World", 0, VIRTUAL_HEIGHT/2-6, VIRTUAL_WIDTH, "center")

	player:render()

	push:finish()

end