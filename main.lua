require 'src/Dependencies'

function love.load() 

	love.graphics.setDefaultFilter('nearest', 'nearest')

	-- Setting up push ( resolution-handling library )
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true,
		fullscreen = false,
		resizable = true
	})

end

-- Setting up so resizing the screen works with push
function love.resize(w, h) 

	push:resize(w, h)

end

function love.update() end

function love.draw() 

	push:start()

	love.graphics.printf("Hello World", 0, VIRTUAL_HEIGHT/2-6, VIRTUAL_WIDTH, "center")

	push:finish()

end