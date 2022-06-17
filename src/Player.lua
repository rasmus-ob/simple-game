Player = Class{}

function Player:init() 

	self.width = 100
	self.height = 10

	self.x = VIRTUAL_WIDTH / 2 - self.width/2
	self.y = VIRTUAL_HEIGHT - self.height 

	-- dx stands for delta x which is speed
	self.dx = 60

end

function Player:update(dt) 

	-- Checking input

	if love.keyboard.isDown('a') then

		player.dx = -PLAYER_SPEED 

	elseif love.keyboard.isDown('d') then

		player.dx = PLAYER_SPEED

	else 

		player.dx = 0
	
	end

	-- Checking so we don't leave the screen
	if self.dx < 0 then

		self.x = math.max(0, self.x + self.dx * dt)

	else 

		self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)

	end
end

function Player:render() 

	-- Setting color to purple
	love.graphics.setColor(255, 0, 255)

	love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)

	-- Reseting color
	love.graphics.setColor(255, 255, 255)

end