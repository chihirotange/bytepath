Player = GameObject:extend()

function Player:update(dt)
    Player.super.update(self, dt)
end

function Player:draw()
    love.graphics.circle("line", self.x, self.y, 10)
end