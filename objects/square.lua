Square = GameObject:extend()

function Square:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end