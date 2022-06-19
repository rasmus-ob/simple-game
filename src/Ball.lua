Ball = Class{}

function Ball:init() 

	self.width = 10
	self.height = 10
	math.randomseed(os.time())
	self.x = math.random(10, VIRTUAL_WIDTH - self.width - 10)

	self.y = math.random(0 - self.height - 10)

	self.speed = math.random(1, 1.4) 


end

function Ball:render()

	-- Setting color to white
	love.graphics.setColor(255, 255, 255)

	love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)

end

function Ball:update() 

	self.y = self.y + self.speed

end