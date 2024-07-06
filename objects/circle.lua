require "objects.gameObject"

Circle = GameObject:extend()

function Circle:draw()
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

function Circle:update(dt)
    Circle.super.update(self, dt)
end