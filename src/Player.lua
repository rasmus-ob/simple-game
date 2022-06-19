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
	love.graphics.setColor(255, 255, 255)

	love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)

end

function Player:levelUp() 

	-- 50% for every stat
	local whatStat = math.random(0, 1)

	print(whatStat)

	if whatStat == 0 then 

		-- Boosts velocity with 50%
		self.dx = self.dx * 1.5

	elseif whatStat == 1 then 

		-- Creates a backup of self.width
		local beforeLevelUpWidth = self.width
	
		-- Boosts width with 20%
		self.width = self.width * 1.2

		-- Creates the offset to x (makes it look like it grows in width on both sides)
		local offsetX = (self.width - beforeLevelUpWidth)/2
	
		-- Adding offset
		self.x = self.x - offsetX

	end


end

function Player:reset() 

	-- Reseting Values

	self.width = 100
	-- self.height = 10

	self.x = VIRTUAL_WIDTH / 2 - self.width/2
	self.y = VIRTUAL_HEIGHT - self.height 

	self.dx = 60


end