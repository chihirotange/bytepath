Room = Object:extend()
currentRoom = nil

function Room:new()
    self.areas = {}
end

function Room:createArea()
    local area = Area()
    table.insert(self.areas, area)
    return area
end

function Room:update(dt)
    for key, area in pairs(self.areas) do
        area:update(dt)
    end
end

function Room:draw()
    for key, area in pairs(self.areas) do
        area:draw()
    end
end

function goToRoom(roomType)
    currentRoom = _G[roomType]
end
