require "objects.circle"
UberCircle = Circle:extend()

function UberCircle:new(x, y, radius, outerRadius, lineWidth)
    UberCircle.super.new(self, x, y, radius)
    self.outerRadius = outerRadius or 0
    self.lineWidth = lineWidth
end

function UberCircle:draw()
    love.graphics.setLineWidth(self.lineWidth)
    UberCircle.super.draw(self)
    love.graphics.circle("line", self.x, self.y, self.outerRadius)
    love.graphics.setLineWidth(1)
end